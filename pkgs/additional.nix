{ config, pkgs, lib, unstable, ... }:
{
    home.packages = with pkgs; [
        arduino # open-source electronics prototyping platform
        blender # 3d creation and animation system
        libreoffice # free and open-source office productivity software suite
        simplescreenrecorder # screen recorder for linux like obs
        steam # video game digital distribution service and storefrontend 
        gnomeExtensions.ddterm # https://extensions.gnome.org/extension/3780/ddterm/
        gnomeExtensions.executor # https://extensions.gnome.org/extension/2932/executor/
        gnomeExtensions.pano # https://extensions.gnome.org/extension/5278/pano/
        # gnomeExtensions.forge # https://extensions.gnome.org/extension/4481/forge/?ref=news.itsfoss.com
    ] ++ (with unstable; [
        unstable.flashprint # slicer for flashforge 3d printers
    ]);
}