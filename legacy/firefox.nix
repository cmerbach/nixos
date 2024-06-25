{ config, pkgs, ... }:
{
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-bin;
        # nativeMessagingHosts.packages = [ pkgs.gnome-browser-connector ];
        policies = {
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
        };
    };
}


# additional in configuration.nix:

# enable gnome browser extension
services.gnome.gnome-browser-connector.enable = true;
nixpkgs.config.firefox.enableGnomeExtensions = true;

#packages = with pkgs; [
#    firefox
#];
