{ config, pkgs, ... }:
{
    # additional pkgs
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
}