{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        libreoffice # free and open-source office productivity software suite
        steam # video game digital distribution service and storefront 
        gnomeExtensions.ddterm # https://extensions.gnome.org/extension/3780/ddterm/
        gnomeExtensions.executor # https://extensions.gnome.org/extension/2932/executor/
    ];
}