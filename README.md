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


### Additional - ...


---


### Links

- https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md
- https://github.com/nix-community/disko/blob/master/docs/quickstart.md
- https://github.com/nix-community/disko/tree/master/example
- https://ertt.ca/nix/shell-scripts/


<!--

Hier könnte Ihre Werbung stehen

-->
