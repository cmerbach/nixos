{ config, pkgs, ... }:
{
    programs.firefox = {
        package = pkgs.firefox-esr;
        # nativeMessagingHosts.packages = [ pkgs.gnome-browser-connector ];
        policies = {
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
        };
    };
}
