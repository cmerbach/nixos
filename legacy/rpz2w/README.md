cd rpz2w/ && nix build -L /home/user/nixos/rpz2w#nixosConfigurations.zero2w.config.system.build.sdImage

# -----
sudo dd if=/dev/zero of=/dev/sdb bs=1MB status=progress

# -----
sudo dd if=result/sd-image/rpz2w.img of=/dev/sdb status=progress

# -----
ssh-keygen -f "/home/user/.ssh/known_hosts" -R "192.168.178.31" && \
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password raspi@192.168.178.31

# -----
-> touch flake.nix
-> touch minimal.nix
git add . && sudo nixos-rebuild switch --flake '.#minimal'



rm -rf /home/user/nixos/rpz2w/result
nix shell nixpkgs#htop
nix --experimental-features "nix-command flakes" 
nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake '.#minimal' root@127.0.0.1


--- Notizen
pcmanfm # file manager with gtk interface???
docker volume create -d local -o type=none -o o=bind -o device=/home/user/tmp/docker/ n8n_data
docker run -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n





# -----
k0sctl init > k0sctl.yaml && nano k0sctl.yaml
#####

#####    
k0sctl apply --config ~/k0sctl.yaml && mkdir -p .kube && k0sctl kubeconfig > ~/.kube/config
mkdir -p .kube && k0sctl kubeconfig > ~/.kube/config




wget https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-standard-3.19.1-x86_64.iso

qemu-img create -f qcow2 alpine.img 15G
qemu-system-x86_64 -enable-kvm -hda alpine.img -cdrom alpine-standard-3.19.1-x86_64.iso -boot d -m 450
qemu-system-x86_64 -enable-kvm -hda alpine.img -m 450 -net nic -net user,hostfwd=tcp::2222-:22

ssh-keygen -f "/home/user/.ssh/known_hosts" -R "127.0.0.1" && ssh -o StrictHostKeyChecking=no root@127.0.0.1 -p2222

# ---
sed -i 's/#//g' /etc/apk/repositories && sed -i 's/8/9/g' /etc/apk/repositories && apk update && \
apk add dbus docker htop k0sctl k9s kubectl nano sshpass tmux util-linux && \
ssh-keygen -N '' -f ~/.ssh/id_ed25519 && \
sshpass -p '123' ssh-copy-id -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no root@127.0.0.1 && \
rc-update add docker default && service docker start && rc-update add dbus default && service dbus start

nano k0sctl.yaml && mkdir -p .kube

k0sctl apply --config /root/k0sctl.yaml && k0sctl kubeconfig > ~/.kube/config
# ---




sed -i 's/#//g' /etc/apk/repositories && sed -i 's/8/9/g' /etc/apk/repositories && apk update
apk add htop k9s kubectl nano sshpass tmux util-linux && \
ssh-keygen -N '' -f ~/.ssh/id_ed25519 && \
sshpass -p '123' ssh-copy-id -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no root@127.0.0.1
 
apk add k3s helm

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true




# Setup Ceph + K0s + Alpine 

```bash
# ssh-keygen -N '' -f ~/.ssh/id_ansible

# prepare the sd card for the first boot
./prepare.sh

# -> boot raspi - connect to raspi
# ssh-keygen -f "/home/user/.ssh/known_hosts" -R "192.168.178.31" && \
#    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password root@192.168.178.31

# -> bootstrap init install
./setup.sh

# set ssh key
sshpass -p '123' ssh-copy-id -i ~/.ssh/id_ansible -o StrictHostKeyChecking=no -o PreferredAuthentications=password "${USER}"@"${IP}"
```


```bash
# verify your inventory

ansible-inventory -i inventory.ini --list

ping the [myhosts] group in your inventory

ansible raspi -m ping -i inventory.ini

Run your playbook.

ansible-playbook -i inventory.ini playbook.yaml


ansible-playbook -i inventory.yaml playbook.yaml --extra-vars "ansible_ssh_user=root"
```











### Legacy - RPZ2W - Raspberry Pi Zero 2 W:

Original: https://github.com/plmercereau/nixos-pi-zero-2.git

```bash
# create image for raspi
nix build -L /home/user/nixos/rpz2w#nixosConfigurations.zero2w.config.system.build.sdImage

# copy image to device/sdcard
cd /home/user/nixos/rpz2w/result/sd-image && sudo dd if=rpz2w.img of=/dev/sda status=progress

# login to raspi
ssh-keygen -f "/home/user/.ssh/known_hosts" -R "192.168.178.31" && \
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password raspi@192.168.178.31
```

---

### Additional - Ceph
<!--
```bash

# create multiple storage devices
qemu-img create -f raw tmp/storage1.img 2G && \
    qemu-img create -f raw tmp/storage2.img 2G && \
    qemu-img create -f raw tmp/storage3.img 2G && \
    qemu-img create -f raw tmp/storage4.img 2G


rm tmp/nixos.img && qemu-img create -f raw tmp/nixos.img 20G
qemu-system-x86_64 -enable-kvm -hda tmp/nixos.img -smp 4 -m 16G -nic user,hostfwd=tcp::8888-:22 -cdrom tmp/nixos.iso -boot d

# -> passwd

ssh-keygen -f "/home/user/.ssh/known_hosts" -R "[127.0.0.1]:8888" && ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password nixos@127.0.0.1 -p 8888
nix --experimental-features "nix-command flakes" shell nixpkgs#git nixpkgs#sshpass
echo "root:password" | sudo chpasswd && \
    ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519 && \
    sshpass -p "password" ssh-copy-id -o StrictHostKeyChecking=no root@127.0.0.1 && \
    git clone https://github.com/cmerbach/nixos.git && cd nixos && \
    echo -n "password" > key.key && \
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake '.#ceph' root@127.0.0.1

# -> reboot

qemu-system-x86_64 -enable-kvm -hda tmp/nixos.img -smp 4 -m 16G -nic user,hostfwd=tcp::8888-:22 -drive file=tmp/storage1.img,format=raw,if=virtio,index=1
ssh-keygen -f "/home/user/.ssh/known_hosts" -R "[127.0.0.1]:8888" && ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password user@127.0.0.1 -p 8888
git clone https://github.com/cmerbach/nixos.git && cd nixos && echo -n "password" > key.key
git add . && sudo nixos-rebuild switch --flake '.#ceph'



sudo cephadm bootstrap --mon-ip 10.0.2.15 --initial-dashboard-user "user" --initial-dashboard-password "password" --dashboard-password-noupdate --cluster-network=10.0.2.15/24


    -drive file=tmp/storage1.img,format=raw,if=virtio,index=1 \
    -drive file=tmp/storage2.img,format=raw,if=virtio,index=2 \
    -drive file=tmp/storage3.img,format=raw,if=virtio,index=3 \
    -drive file=tmp/storage4.img,format=raw,if=virtio,index=4
```

# Enable sound with pipewire.
sound.enable = true;
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

-->