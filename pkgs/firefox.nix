{ config, pkgs, ... }:
{
    programs.firefox = {
        package = pkgs.firefox;
        # nativeMessagingHosts.packages = [ pkgs.gnome-browser-connector ];
        policies = {
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
        };
    };
}
