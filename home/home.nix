{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "user";
    home.homeDirectory = "/home/user";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.

    imports = with pkgs; [
        ../pkgs/additional.nix
        ../pkgs/base.nix
        ../pkgs/exb.nix
    ];

    home.packages = with pkgs; [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello     
        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
    ];

    # gnome settings
    # https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
    dconf.settings = {
        "org/gnome/desktop/interface" ={
            color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/interface" ={
            gtk-theme = "Adwaita-dark";
            show-battery-percentage = true;
        };
        "org/gnome/settings-daemon/plugins/power" = {
            idle-dim = false;
            sleep-inactive-ac-timeout = 0;
            sleep-inactive-battery-timeout = 0;
        };
        "org/gnome/shell" = {
            disable-user-extensions = false;
            disabled-extensions = "disabled";
            enabled-extensions = [
                "executor@raujonas.github.io"
                "ddterm@amezin.github.com"
                "trayIconsReloaded@selfmade.pl"
                "pano@elhan.io" 
                "forge@jmmaranan.com"
            ];
            favorite-apps = [ "pcmanfm.desktop" "org.gnome.Console.desktop" "firefox.desktop" "codium.desktop" "lorien.desktop" "FlashPrint5.desktop" ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
            ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            name = "firefox";
            command = "firefox";
            binding = "<Ctrl><Alt>f";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
            name = "gnome-terminal";
            command = "kgx";
            binding = "<Ctrl><Alt>t";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
            name = "vscode-tab";
            command = "firefox --new-window https://127.0.0.1:31545";
            binding = "<Ctrl><Alt>v";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
            name = "vscode-kiosk";
            command = "firefox --new-window https://127.0.0.1:31545 --kiosk";
            binding = "<Ctrl><SUPER>v";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
            name = "flameshot";
            command = "flameshot gui";
            binding = "<SHIFT><Ctrl><ALT>f";
        };
    };

    # bashrc
    programs.bash = {
        enable = true;
        enableCompletion = true;

        # set some aliases
        shellAliases = {
            nr = "git -C  /home/user/nixos/ add .&& sudo nixos-rebuild switch --flake '/home/user/nixos/#full' && source /home/user/.bashrc";
            ng = "sudo nix-collect-garbage -d";
        };

        # some bash functions
        initExtra = ''
            np () {
                nix shell nixpkgs#"$1";
            }
        '';

        bashrcExtra = ''
        # example
        # export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
        eval "$(direnv hook bash)"
        '';
    };

    programs.git = {
        enable = true;
        userName  = "cmerbach";
        userEmail = "christian.merbach@gmx.de";
    };

    programs.ssh = {
      enable = true;
	    extraConfig = ''
        # a private key that is used during authentication will be added to ssh-agent if it is running
        AddKeysToAgent yes
            Host github.com
                HostName github.com
                IdentityFile ~/.ssh/id_github
                IdentitiesOnly yes

        AddKeysToAgent yes
            Host gitlab.com
                HostName gitlab.com
                IdentityFile ~/.ssh/id_gitlab
                IdentitiesOnly yes
	    '';
    };

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        # EDITOR = "emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
