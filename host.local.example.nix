{ config, pkgs, ... }:
{
    # Define your hostname
    networking.hostName = "hostname";
    users.users.user = {
        packages = with pkgs; [
            # brave
            # skypeforlinux
            # telegram-desktop
        ];
    };

    # additional programs
    # programs.steam = {
    #     enable = true;
    #     remotePlay.openFirewall = true;
    #     dedicatedServer.openFirewall = true;
    #     localNetworkGameTransfers.openFirewall = true;
    # };

    # This value determines the NixOS release (first version of NixOS you have
    # installed on this particular machine) from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    
    system.stateVersion = "24.05";
}