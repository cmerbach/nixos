#!/usr/bin/env -S nix --experimental-features "nix-command flakes" shell nixpkgs#bash nixpkgs#cowsay nixpkgs#git nixpkgs#sshpass --command bash

cowsay I will install nixos - server

# change the root password
echo "root:pwinit" | sudo chpasswd

# create a ssh key for the host system
echo "y" | ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519

# copy the ssh key to the root dir on the host system
sshpass -p "pwinit" ssh-copy-id -o StrictHostKeyChecking=no root@127.0.0.1

# download repo
# xport BRANCH=fixes
if [ -z "$BRANCH" ]; then
    # BRANCH is not set, run the default command
    echo "You are using MAIN branch"
    git clone https://github.com/cmerbach/nixos.git && cd nixos/
else
    # BRANCH is set, run the alternative command
    echo "You are using $BRANCH branch"
    git clone --single-branch --branch "$BRANCH" ttps://github.com/cmerbach/nixos.git && cd nixos/
fi

# user input to change the install device
lsblk && echo -n "Choose device for install: " && read -r device
if [ ! -z "$device" ]; then
    sed -i "s/device = lib\.mkDefault \"\/dev\/.*$/device = lib\.mkDefault \"\/dev\/$device\";/" disko.nix
fi
echo "No changes"

# user input for password full disk encryption
echo "Enter password for fulldiskencryption:"
read -r -s user_input_secret
echo -n "$user_input_secret" > /tmp/luks.key

# run install
nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake '.#minimal' root@127.0.0.1
