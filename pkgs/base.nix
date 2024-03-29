{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        audacity # audio editing and recording software
        btop # monitor of resources
        curl # cli tool for transferring data using various network protocols
        ffmpeg # free and open-source software consisting of a suite of libraries for video, audio, and other multimedia files
        flameshot # free and open-source tool to take screenshots with many built-in features 
        gimp # cross-platform image editor
        htop # cross-platform interactive process viewe
        iftop # cli system monitor toolfor network traffic
        kdenlive # free and open source cross-platform video editing program
        lorien # infinite canvas drawing/note-taking app
        mkvtoolnix # set of tools used for creating, modifying, and inspecting mkv files
        mpv # free media player for the command line
        nnn # full-featured terminal file manager
        nomacs # free and open source image viewer
        pcmanfm # file manager with gtk interface
        pdfarranger # python-gtk application to merge or split PDF documents
        python3 # universal, interpreted, high-level programming language
            python311Packages.duckdb
            python311Packages.pandas
        qemu # generic and open source machine emulator and virtualizer
        solaar #  linux manager for many Logitech devices
        tig # text-mode interface for Git
        tmux # terminal multiplexer
        tree # view directory hierarchy recursively as a tree structure
        vlc # free and open source cross-platform multimedia player
        vscodium # open source software of vs code
        wget # free software package for retrieving files using HTTP, HTTPS, FTP and FTPS
        yt-dlp # cli tool to download videos from YouTube (youtube-dl fork)
    ];
}