# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, unstable, ... }:

{
    imports = [
        # Include the results of the hardware scan
        ./config/host.nix
        ./pkgs/virtualization.nix
    ];

    # enable flakes command
    nix.settings.experimental-features = [ "nix-command flakes" ];
    # enable unfree software
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;
    nixpkgs.config.android_sdk.accept_license = true; 
    # enable all firmware regardless of license
    hardware.enableAllFirmware = true;
    # allow insecure software
    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

    # Use the GRUB 2 boot loader.
    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.efiInstallAsRemovable = true;
    # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # https://github.com/plmercereau/nixos-pi-zero-2
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you want to install Grub.
    # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only # Disko will take care of that automatically
    # enable dmesg logging
    boot.kernelParams = [ "loglevel=7" ];
    # enable syslog-ng for traditional syslog files (optional)
    services.syslog-ng.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Enable networking
    networking.networkmanager.enable = true;

    # Define your hostname
    networking.hostName = builtins.readFile config/hostName.nix;

    # Pick only one of the below networking options.
    # or use unmanaged for both
    # networking.networkmanager.unmanaged = [ "wlp3s0" ];
    # Enables wireless support via wpa_supplicant
    # networking.wireless.enable = true;
    # networking.wireless.interface = [ "wlp3s0" ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "de_DE.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "de";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # ---( Enable GNOME Desktop Environment )---#
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = false;
    services.xserver.desktopManager.gnome.enable = true;

    # enable displaylink and the usage of monitors via displayport
    # ---(pre install steps)---
    # nix-prefetch-url --name displaylink-580.zip https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip
    # sudo systemctl start dlm.service
    # -----
    # services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
    # ---
    # disable pre-installed gnome packages
    environment.gnome.excludePackages = with pkgs.gnome; [
        gnome-calculator
        gnome-calendar
        gnome-characters
        gnome-clocks
        gnome-contacts
        gnome-font-viewer
        gnome-logs
        gnome-maps
        gnome-music
        gnome-system-monitor
        gnome-weather
    ] ++ (with pkgs; [
        baobab      # disk usage analyzer
        epiphany    # web browser
        geary       # email client
        gnome-tour  # simple introduction for gnome
        # seahorse    # password managergnome
        simple-scan # document scanner
        totem       # video player
        yelp        # help viewer
    ]);
    #-----

    # Configure keymap in X11
    services.xserver.xkb.layout = "de";
    services.xserver.xkb.variant = "";

    # Configure console keymap
    console.keyMap = "de";

    # Enable CUPS to print documents
    services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    # hardware.pulseaudio.enable = true;
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager)
    services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with passwd
    users.users.user = {
        isNormalUser = true;
        description = "user"; # managed by home-manager
        hashedPassword = "$6$U3SyXldxX47qXKo9$7IUNCifC7iZp7O6ldKA6gbMtsIuTG0XG0EBKErBD.uURbZ4fbqUgni0SbzlgXXP4phTJuDlh5VEki0HmHwxYs/"; # mkpasswd --method=SHA-512 --stdin
        extraGroups = [
            "adbusers"
            "dialout" # arduino permission for /dev/ttyUSB0
            "docker"
            "kvm"
            "libvirtd"
            "networkmanager"
            "wheel" # enables 'sudo' for the user
        ]; 
        # packages = with pkgs; [
        #    firefox
        # ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        git
        nodejs
        openssl
    ];

    # set xdg user dirs
    environment.etc = {
        "xdg/user-dirs.defaults".text = ''
            DOWNLOAD=Downloads
        '';
    };

    # running command after install
    system.userActivationScripts = {
        jdownloader2 = {
            text = ''
                JDOWNLOADER_PATH="/home/user/.jdownloader2"
                if [ ! -d "$JDOWNLOADER_PATH" ]; then
                    mkdir -p "$JDOWNLOADER_PATH"
                    ${pkgs.megatools}/bin/megadl https://mega.nz/file/LZVEnKJI#4gzq0u-6n_adkIMcw3UiN_WUhi3JgFmin93tiIqo58Q --path "$JDOWNLOADER_PATH"
                fi
            '';
        };
    };

    # enable YubiKey support and also for Android SDK
    services.udev.packages = with pkgs; [ 
        yubikey-personalization
        android-udev-rules
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;

    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    # settings for Android SDK
    programs.adb.enable = true;

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    # This value determines the NixOS release (first version of NixOS you have
    # installed on this particular machine) from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    
    system.stateVersion = builtins.readFile config/stateVersion.nix;
}
