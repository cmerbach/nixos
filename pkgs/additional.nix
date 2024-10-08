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
        gnomeExtensions.clipboard-indicator # https://extensions.gnome.org/extension/779/clipboard-indicator/
        gnomeExtensions.ddterm # https://extensions.gnome.org/extension/3780/ddterm/
        gnomeExtensions.docker # https://extensions.gnome.org/extension/5103/docker/
        gnomeExtensions.executor # https://extensions.gnome.org/extension/2932/executor/
        gnomeExtensions.tiling-assistant # https://extensions.gnome.org/extension/3733/tiling-assistant/
        gnomeExtensions.tray-icons-reloaded # https://extensions.gnome.org/extension/2890/tray-icons-reloaded/
        gnomeExtensions.wtmb-window-thumbnails # https://extensions.gnome.org/extension/6816/wtmb-window-thumbnails/
        # gnomeExtensions.forge # https://extensions.gnome.org/extension/4481/forge/?ref=news.itsfoss.com
        gnome.simple-scan # simple scanning utility
        gnome.zenity # tool to display gui dialogs from the commandline and shell scripts
        megatools # command line client for mega.nz
        pv #Tool for monitoring the progress of data through a pipeline
        yazi # fast terminal file manager written in rust, based on async I/O
        file # program that shows the type of files
            ffmpegthumbnailer # lightweight video thumbnailer
            poppler # pdf rendering library
            fd # simple, fast and user-friendly alternative to find
            fzf # cli fuzzy finder written in Go
            zoxide # fast cd command that learns your habits
            imagemagick # software suite to create, edit, compose, or convert bitmap images
            xclip # tool to access the x clipboard from a console application
        yt-dlp # cli tool to download videos from youtube
        yubikey-manager # cli tool for configuring any YubiKey over all USB transports
        yubikey-manager-qt # cross-platform application for configuring any YubiKey over all USB interfaces
        yubikey-personalization-gui # qt based cross-platform utility designed to facilitate reconfiguration of the Yubikey
    ] ++ (with unstable; [
        flashprint # slicer for flashforge 3d printers
    ]);
}
