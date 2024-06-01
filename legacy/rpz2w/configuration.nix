{ lib, modulesPath, pkgs, ...}:
{

    imports = [
        ./sd-image.nix
    ];

    nixpkgs.hostPlatform = "aarch64-linux";
    # ! Need a trusted user for deploy-rs.
    nix.settings.trusted-users = ["@wheel"];
    system.stateVersion = "23.11";

    # zramSwap = {
    #     enable = false;
    #     algorithm = "zstd";
    # };

    sdImage = {
        # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low on space.
        compressImage = false;
        imageName = "rpz2w.img";

        extraFirmwareConfig = {
            # Give up VRAM for more Free System Memory - Disable camera which automatically reserves 128MB VRAM
            start_x = 0;
            # - Reduce allocation of VRAM to 16MB minimum for non-rotated (32MB for rotated)
            gpu_mem = 16;

            # Configure display to 800x600 so it fits on most screens
            # * See: https://elinux.org/RPi_Configuration
            hdmi_group = 2;
            hdmi_mode = 8;
        };
    };

    # enable flakes command
    nix.settings.experimental-features = [ "nix-command flakes" ];
    # enable unfree software
    nixpkgs.config.allowUnfree = true;
    # enable all firmware regardless of license
    hardware.enableAllFirmware = true;

    boot = {
        initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
        loader = {
            grub.enable = false;
            generic-extlinux-compatible.enable = true;
        };

        # Avoids warning: mdadm: Neither MAILADDR nor PROGRAM has been set. This will cause the `mdmon` service to crash.
        # See: https://github.com/NixOS/nixpkgs/issues/254807
        swraid.enable = lib.mkForce false;
    };

    # networking.wireless.userControlled.enable = true;
    networking.wireless.enable = true;
    networking.wireless.networks."Fritz2Box" ={
        hidden = true;
        pskRaw = "1665fb4f747951089e85b997cd4510535af41a108298619f7d6e50803fbf107f"; # wpa_passphrase SSID password
    };

    # Enable OpenSSH out of the box.
    services.sshd.enable = true;

    # NTP time sync.
    services.timesyncd.enable = true;

    # Define a user account. Don't forget to set a password with passwd
    users.users.raspi = {
        isNormalUser = true;
        home = "/home/raspi";
        description = "raspi";
        hashedPassword = "$6$U3SyXldxX47qXKo9$7IUNCifC7iZp7O6ldKA6gbMtsIuTG0XG0EBKErBD.uURbZ4fbqUgni0SbzlgXXP4phTJuDlh5VEki0HmHwxYs/";
        extraGroups = [ "docker" "wheel" "networkmanager" ];
        packages = with pkgs; [
                btop
                htop
                libraspberrypi
                neofetch
                # install ceph
                docker
                rsyslog
            ];
        # Be sure to put your own public key here
        # openssh.authorizedKeys.keys = ["a public key"];
    };

    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };

    security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
    };
    
    # Be sure to change the autologinUser.
    # services.getty.autologinUser = "raspi";
}
