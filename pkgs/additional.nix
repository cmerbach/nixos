{ config, pkgs, lib, unstable, ... }:
{
    home.packages = with pkgs; [
        ansible #  open source it automation engine (automates provisioning, configuration, deployment, orchestration ...)
        arduino # open-source electronics prototyping platform
        blender # 3d creation and animation system
        flutter # googles sdk for building mobile, web and desktop with dart
        libreoffice # free and open-source office productivity software suite
        parted # create, destroy, resize, check, and copy partitions
        simplescreenrecorder # screen recorder for linux like obs
        sshpass # non-interactive ssh password auth
        gnomeExtensions.ddterm # https://extensions.gnome.org/extension/3780/ddterm/
        gnomeExtensions.executor # https://extensions.gnome.org/extension/2932/executor/
        gnomeExtensions.tray-icons-reloaded # https://extensions.gnome.org/extension/2890/tray-icons-reloaded/
        # gnomeExtensions.pano # wird aktuell nicht unterstützt https://extensions.gnome.org/extension/5278/pano/
        # gnomeExtensions.forge # https://extensions.gnome.org/extension/4481/forge/?ref=news.itsfoss.com
        megatools # command line client for mega.nz
        pv
        yt-dlp # cli tool to download videos from youtube
        yubikey-manager # cli tool for configuring any YubiKey over all USB transports
        yubikey-manager-qt # cross-platform application for configuring any YubiKey over all USB interfaces
        yubikey-personalization-gui # qt based cross-platform utility designed to facilitate reconfiguration of the Yubikey
    ] ++ (with unstable; [
        flashprint # slicer for flashforge 3d printers
    ]);
}
