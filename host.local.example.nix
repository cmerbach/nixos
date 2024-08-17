{ config, pkgs, ... }:
{
    # Define your hostname
    networking.hostName = "nixos2";

    # users.users.user = {
    #     packages = with pkgs; [
    #         brave
    #     ];
    # };
}