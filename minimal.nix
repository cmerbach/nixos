{ config, lib, pkgs, ... }:

{
    imports =
        [
            # Include the results of the hardware scan.
            # ./pkgs/vscode.nix
        ];

    # enable flakes command
    nix.settings.experimental-features = [ "nix-command flakes" ];
    # enable unfree software
    nixpkgs.config.allowUnfree = true;
    # enable all firmware regardless of license
    hardware.enableAllFirmware = true;

    # Use the GRUB 2 boot loader.
    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.efiInstallAsRemovable = true;
    # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_7;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    # boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # https://github.com/plmercereau/nixos-pi-zero-2
    
    # network settings
    networking.hostName = "nixos-minimal";
    networking.networkmanager.enable = true;
    services.openssh.enable = true;
    console.keyMap = "de";

    users.users.user = {
        isNormalUser = true;
        home = "/home/user";
        description = "user";
        hashedPassword = "$6$U3SyXldxX47qXKo9$7IUNCifC7iZp7O6ldKA6gbMtsIuTG0XG0EBKErBD.uURbZ4fbqUgni0SbzlgXXP4phTJuDlh5VEki0HmHwxYs/";
        extraGroups = [ "networkmanager" "wheel" ];
        # packages = with pkgs; [
        #     git
        # ];
    };

    environment.systemPackages = with pkgs; [
        git
        # nodejs
    ];

    environment.interactiveShellInit = ''
        alias nrm="git -C /home/user/nixos/ add . && sudo nixos-rebuild switch --flake '/home/user/nixos/#minimal'";
    '';

    system.stateVersion = "24.05";

}