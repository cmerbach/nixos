# nixos


---


### Quick and dirty setup guide

```bash
# create a tmp folder
mkdir -p tmp

# download the current version of nixos
wget https://channels.nixos.org/nixos-23.11/latest-nixos-minimal-x86_64-linux.iso -O tmp/nixos.iso

# create the device for install the os
qemu-img create -f raw tmp/nixos.img 50G

# run the boot command
qemu-system-x86_64 -enable-kvm -hda tmp/nixos.img -smp 8 -m 16G -nic user,hostfwd=tcp::8888-:22 -cdrom tmp/nixos.iso -boot d

#---( set a password to root in the vm )---#
# ~$ passwd
#---

# login to vm
ssh-keygen -f "/home/user/.ssh/known_hosts" -R "[127.0.0.1]:8888" && \
    ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password nixos@127.0.0.1 -p 8888
# login to remote
# ssh-keygen -f "/home/user/.ssh/known_hosts" -R "192.168.178.30" && \
#     ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password nixos@192.168.178.30

# download repo and server install
curl -O https://raw.githubusercontent.com/cmerbach/nixos/main/install.sh && chmod +x install.sh && ./install.sh

# reboot and start the system
qemu-system-x86_64 -enable-kvm -hda tmp/nixos.img -smp 8 -m 16G -nic user,hostfwd=tcp::8888-:22

# download repo and desktop install
git clone https://github.com/cmerbach/nixos.git && cd nixos && chmod +x update.sh && ./update.sh

# set repo to ssh
cd && cd nixos/ && git remote set-url origin git@github.com:cmerbach/nixos.git
```

<br>

> **_-cpu \<CPU> :_**  Specify a processor architecture to emulate. To see a list of supported architectures, run: ```qemu-system-x86_64 -cpu```

> **_-cpu host :_** (Recommended) Emulate the host processor

> **_-smp \<NUMBER> :_** Specify the number of cores the guest is permitted to use. The number can be higher than the available cores on the host system. Use -smp $(nproc) to use all currently available cores


---


### Some other information:

- ⚠️ **it must always be stage by git**
- ```sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/....nix```
- ```nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake '.#nixos' --vm-test```
- ```nixos-rebuild switch --flake '.#myconfig' --target-host root@192.168.56.103 --build-host localhost --verbose```
- If you prefer to build the configuration on the remote host, replace --build-host localhost with --build-host root@192.168.4.1
- -> check if i can run disko after install with sudo nixos-rebuild -> yupp ist möglich und kann dir dein gesamtes system zerschießen -> nixos hat rollback geiler scheiß
- boot alpine and install nixos -> es muss jedoch eine bash vorhanden sein


##### <ins>Aliases:</ins>

- **nr** - ```sudo nixos-rebuild switch --flake '.#nixos'```
- **np \$1** - ```nix shell nixpkgs#"$1"```
- **ng** - ```sudo nix-collect-garbage -d```


##### <ins>Additional hardware configurations:</ins>

```nix
boot.initrd.availableKernelModules = [ "iwlwifi" "xhci_pci" "ahci" "nvme" "usb_storage" "ehci_pci" "usbhid" "rtsx_usb_sdmmc" "ata_piix" "ohci_pci" "sd_mod" "sr_mod" ];
---
boot.initrd.kernelModules = [ ];
---
boot.kernelModules = [ "kvm-intel" ];
---
boot.extraModulePackages = [ ];
---
nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
---
hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
---
networking.useDHCP = lib.mkDefault true;
```


---

### Open questions:
- [ ] write a function that vscode-server FILE will open browser
- [ ] copy full disk encryption to yubikey 
- [ ] how to enable fulldisk encryption on rpz2w
- [ ] search for a customizable terminal
- [ ] save ui layout of vscode
- [ ] remove ceph config from repo and flake.nix
- [ ] customize shell extensions over gnome.dconf.editor

---


### Additional - RPZ2W - Raspberry Pi Zero 2 W:

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


---


### Links

- https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md
- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/nix-community/disko/tree/master/example
- https://ertt.ca/nix/shell-scripts/


<!--

Hier könnte Ihre Werbung stehen

-->
