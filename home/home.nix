{ config, pkgs, lib, ... }:

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

    imports = [
        ../pkgs/additional.nix
        ../pkgs/base.nix
        ../pkgs/exb.nix
        ../pkgs/vscodium.nix
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
        "org/gnome/desktop/session" = {
            idle-delay = (lib.hm.gvariant.mkUint32 0);
        };
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/interface" = {
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
                # "forge@jmmaranan.com"
            ];
            favorite-apps = [ "nautilus.desktop" "org.gnome.Console.desktop" "firefox.desktop" "codium.desktop" "thunderbird.desktop" "slack.desktop" "lorien.desktop" "FlashPrint5.desktop" ];
        };
        # settings for the individual gnome extensions
        "org/gnome/shell/extensions/executor" = {
            click-on-output-active = false;
            left-active = false;
            left-index = 0;
            center-active = false;
            center-index = 0;
            right-active = true;
            right-index = 0;
        };
        "com/github/amezin/ddterm" = {
            ddterm-toggle-hotkey = "<Control><Alt>a";
        };
        # custom keybindings shortcuts
        "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
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
            binding = "<Ctrl><SHIFT><Alt>t";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
            name = "thunderbird";
            command = "thunderbird";
            binding = "<Ctrl><SHIFT><Alt>t";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
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
            # docker
            nn = "docker run -it --rm --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n";
            # nixos
            nr = "rm -rf /home/user/.vscode-oss && git -C /home/user/nixos/ add . && sudo nixos-rebuild switch --flake '/home/user/nixos/#full' && source /home/user/.bashrc";
            nu = "git -C  /home/user/nixos/ add . && sudo nix flake update '/home/user/nixos' && sudo nixos-rebuild switch --flake '/home/user/nixos/#full' && source /home/user/.bashrc";
            ng = "sudo nix-collect-garbage -d";
            # git
            ga = "git add .";
            gh = "git rebase -i main";
            gp = "git push --force-with-lease";
            gs = "git status";
        };

        # some bash functions
        initExtra = ''
            np () {
                export NIXPKGS_ALLOW_UNFREE=1;
                nix shell --impure nixpkgs#"$1";
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
        includes = [ 
            { contents.commit.gpgSign = false; }
        ];
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

    # NOTE required when working with binary-python-packages without poetry2nix
    home.sessionVariables.LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    home.sessionVariables.PDM_VENV_BACKEND = "venv";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
