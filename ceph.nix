{ config, lib, pkgs, ... }:

{
    imports =
        [
            # Include the results of the hardware scan.
        ];

    # enable flakes command
    nix.settings.experimental-features = [ "nix-command flakes" ];
    # enable unfree software
    nixpkgs.config.allowUnfree = true;
    # allow insecure software
    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];
    
    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.efiInstallAsRemovable = true;
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # https://github.com/plmercereau/nixos-pi-zero-2
    networking.hostName = "nixos";
    services.openssh.enable = true;

    users.users.user = {
        isNormalUser = true;
        home = "/home/user";
        description = "user";
        hashedPassword = "$6$U3SyXldxX47qXKo9$7IUNCifC7iZp7O6ldKA6gbMtsIuTG0XG0EBKErBD.uURbZ4fbqUgni0SbzlgXXP4phTJuDlh5VEki0HmHwxYs/";
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
            git
        ];
    };

    environment.interactiveShellInit = ''
        alias nrc="git -C /home/user/nixos/ add . && sudo nixos-rebuild switch --flake '/home/user/nixos/#ceph'";
    '';

    environment.systemPackages = with pkgs; [
        ceph
        docker
        rsyslog
    ];
    
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
    # virtualisation.docker.daemon.settings = {
    #     data-root = "/some-place/to-store-the-docker-data";
    # };

    system.stateVersion = "23.11"; # Did you read the comment?

}