{ config, pkgs, ... }:
{
    # system.activationScripts = {
    system.userActivationScripts = {
        code-server-install = {
            text = ''
                path_vscode="/home/user/.local/lib/"

                # using system packages like -curl-
                source ${config.system.build.setEnvironment}

                # https://github.com/coder/code-server
                curl -fsSL https://code-server.dev/install.sh | sh

                # clean up - find all older versions and delete them
                find $path_vscode -maxdepth 1 -type d -name "code-server-*" | grep -v "$(ls -1 "$path_vscode" | grep "^code-server-" | sort -V | tail -n 1)" | xargs rm -rf

                # tell code-server where to finde nodejs 
                version=$(ls ~/.local/lib/)
                path_nodejs=$(which node)
                rm ~/.local/lib/$version/lib/node
                ln -s $path_nodejs ~/.local/lib/$version/lib/node

                # install and update all extensions
                /home/user/.local/bin/code-server --config "/home/user/nixos/custom/vscode/code-server-config.yml" \
                    --install-extension bbenoist.nix --force \
                    --install-extension foam.foam-vscode --force \
                    --install-extension github.vscode-pull-request-github --force \
                    --install-extension gruntfuggly.todo-tree --force \
                    --install-extension james-yu.latex-workshop --force \
                    --install-extension janisdd.vscode-edit-csv --force \
                    --install-extension johnpapa.vscode-peacock --force \
                    --install-extension mhutchie.git-graph --force \
                    --install-extension ms-python.python --force \
                    --install-extension ms-toolsai.jupyter --force \
                    --install-extension tonybaloney.vscode-pets --force \
                    --install-extension yzhang.markdown-all-in-one --force
            '';
        };
    };


    # Running in root mode by setting:
    #   systemd.services.code-server
    #   systemctl status code-server.service
    # systemctl --user status code-server.service
    # also possible: wantedBy = [ "multi-user.target" ];
    # Repo: https://github.com/coder/code-server
    systemd.user.services.code-server = {
        enable = true;
        description = "code-server";
        path = [ pkgs.openssl ];
        environment = {
            CODE_SERVER_CONFIG = "/home/user/nixos/custom/vscode/code-server-config.yml";
        };
        serviceConfig = {
            user = "user";
            ExecStart = "/home/user/.local/bin/code-server";
        };
        wantedBy = [ "default.target" ];
    };
}