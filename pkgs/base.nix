{ config, pkgs, lib, unstable, ... }:
{
    home.packages = with pkgs; [
        asciidoc-full # text-based document generation system
        audacity # audio editing and recording software
        btop # monitor of resources
        busybox # tiny versions of common unixutilities in a single small executable - e.g. killall
        curl # cli tool for transferring data using various network protocols
        ffmpeg # free and open-source software consisting of a suite of libraries for video, audio, and other multimedia files
        flameshot # free and open-source tool to take screenshots with many built-in features 
        gimp # cross-platform image editor
        gnome.dconf-editor # gsettings editor for gnome
        gnome-extension-manager # desktop app for managing GNOME shell extensions - command: extension-manager
        #!!! gnupg # openpgp implementation -> installed in the configuration.nix
        gzip # gnu zip compression program
        htop # cross-platform interactive process viewe
        iftop # cli system monitor toolfor network traffic
        jdk21 # java currently-supported LTS version of OpenJDK
        kdenlive # free and open source cross-platform video editing program
        libvirt # toolkit to interact with the virtualization capabilities of linux
        lorien # infinite canvas drawing/note-taking app
        lvm2 # support logical volume management (lvm) on linux
        mdadm # managing raid arrays under linux
        mkvtoolnix # set of tools used for creating, modifying, and inspecting mkv files
        mpv # free media player for the command line
        nnn # full-featured terminal file manager
        nomacs # free and open source image viewer
        p7zip # command line tool fork of the free 7-zip archive program for posix platforms
        pdfarranger # python-gtk application to merge or split PDF documents
        #!!! python3 # universal, interpreted, high-level programming language
        (python3.withPackages (python-pkgs: [
            python-pkgs.pandas
            python-pkgs.duckdb
            python-pkgs.pip
            python-pkgs.virtualenv
            python-pkgs.identify
            python-pkgs.cfgv
            python-pkgs.pre-commit-hooks
        ]))
        qemu # generic and open source machine emulator and virtualizer
        solaar #  linux manager for many Logitech devices
        tig # text-mode interface for Git
        tmux # terminal multiplexer
        tree # view directory hierarchy recursively as a tree structure
        vivaldi-ffmpeg-codecs # additional support for proprietary codecs for vivaldi
        vlc # free and open source cross-platform multimedia player
        wget # free software package for retrieving files using HTTP, HTTPS, FTP and FTPS
        xournalpp # software for pdf annotation support
        yt-dlp # cli tool to download videos from YouTube (youtube-dl fork)
    ] ++ (with unstable; [
        vivaldi # powerful, personal and private browser
    ]);
}