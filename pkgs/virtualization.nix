{ config, pkgs, ... }:
{
    # ---( docker )---
    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };

    # virtualisation.docker.daemon.settings = {
    #     data-root = "/some-place/to-store-the-docker-data";
    # };

    # ---( libvirtd )---
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
                enable = true;
                packages = [(pkgs.OVMF.override {
                    secureBoot = true;
                    tpmSupport = true;
                }).fd];
            };
        };
    };

    # ---( virtualbox )--- extremely feature rich, high performance product for enterprise customers
    # add "virtualbox" to additional.nix
    # virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.host.enableExtensionPack = true;
    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.x11 = true;
    # users.extraGroups.vboxusers.members = [ "user" ];
}