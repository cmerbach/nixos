{ config, pkgs, ... }:
{
        # ---( docker )--- settings
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
    # virtualisation.docker.daemon.settings = {
    #     data-root = "/some-place/to-store-the-docker-data";
    # };


    # ---( virtualbox )--- extremely feature rich, high performance product for enterprise customers
    # add "virtualbox" to additional.nix
    # virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.host.enableExtensionPack = true;
    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.x11 = true;
    # users.extraGroups.vboxusers.members = [ "user" ];
}