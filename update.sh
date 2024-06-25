#!/usr/bin/env -S nix shell nixpkgs#bash nixpkgs#cowsay -- command bash

# nixpkgs#bash - 
# nixpkgs#cowsay - 


cowsay I will install nixos - destop


# create a ssh key for the gitlab repo
ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_github && cat ~/.ssh/id_github.pub

# create a local host file
# https://discourse.nixos.org/t/can-i-use-flakes-within-a-git-repo-without-committing-flake-nix/18196
cp host.local.example.nix host.local.nix
git add --intent-to-add host.local.nix flake.lock
git update-index --assume-unchanged host.local.nix flake.lock

# change the disko.nix file after reload
device=$(lsblk | grep -B 2 "/boot$" | head -n1 | cut -d' ' -f1)
sed -i "s/device = lib\.mkDefault \"\/dev\/.*$/device = lib\.mkDefault \"\/dev\/${device}\";/" disko.nix

# run install
git add . && sudo nixos-rebuild switch --flake '.#full'
