# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            # ./hardware-configuration.nix
            ./host.local.nix
            ./pkgs/firefox.nix
            ./pkgs/vscode.nix
            ./pkgs/virtualization.nix
        ];

    # enable flakes command
    nix.settings.experimental-features = [ "nix-command flakes" ];
    # enable unfree software
    nixpkgs.config.allowUnfree = true;
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
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # https://github.com/plmercereau/nixos-pi-zero-2
    # boot.loader.efi.efiSysMountPoint = "/boot/efi";
    # Define on which hard drive you want to install Grub.
    # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only # Disko will take care of that automatically

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Enable networking
    networking.networkmanager.enable = true;

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

    #---( Enable GNOME Desktop Environment )---#
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = false;
    services.xserver.desktopManager.gnome.enable = true;
    # disable pre-installed gnome packages
    environment.gnome.excludePackages = with pkgs.gnome ; [
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
        nautilus    # file manager
        seahorse    # password managergnome
        simple-scan # document scanner
        totem       # video player
        yelp        # help viewer
    ]);
    # enable gnome browser extension
    services.gnome.gnome-browser-connector.enable = true;
    nixpkgs.config.firefox.enableGnomeExtensions = true;
    # stop pc from sleep
    # get information via: gsettings get org.gnome.desktop.session idle-delay
    system.userActivationScripts = {
        disable-black-screen = {
            text = ''
              gsettings set org.gnome.desktop.session idle-delay 0
            '';
        };
    };
    #-----

    # Configure keymap in X11
    services.xserver.xkb.layout = "de";
    services.xserver.xkbVariant = "";

    # Configure console keymap
    console.keyMap = "de";

    # Enable CUPS to print documents
    services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable touchpad support (enabled default in most desktopManager)
    services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with passwd
    users.users.user = {
        isNormalUser = true;
        description = "user"; # managed by home-manager
        hashedPassword = "$6$U3SyXldxX47qXKo9$7IUNCifC7iZp7O6ldKA6gbMtsIuTG0XG0EBKErBD.uURbZ4fbqUgni0SbzlgXXP4phTJuDlh5VEki0HmHwxYs/"; # mkpasswd --method=SHA-512 --stdin
        extraGroups = [ "networkmanager" "wheel" ]; #  wheel - enables 'sudo' for the user
        packages = with pkgs; [
            firefox-esr
        ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        git
        nodejs
        openssl
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

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

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    
    system.stateVersion = "23.11";
}
