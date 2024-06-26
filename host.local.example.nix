{ config, pkgs, ... }:
{
    # Define your hostname
    networking.hostName = "nixos";

    users.users.user = {
        packages = with pkgs; [
            # brave
            # skypeforlinux
            telegram-desktop
        ];
    };
}