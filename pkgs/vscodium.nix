{ config, pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            foam.foam-vscode
            github.vscode-pull-request-github
            gruntfuggly.todo-tree
            james-yu.latex-workshop
            johnpapa.vscode-peacock
            mhutchie.git-graph
            ms-python.python
            ms-toolsai.jupyter
            yzhang.markdown-all-in-one
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
                name = "sidebar-markdown-notes";
                publisher = "assisrMatheus";
                version = "1.2.0";
                sha256 = "yM9Hxuv9sIDq1vz5hcvrNUvZ9gbelhbc80v0++aJgQE=";
            }
            {
                name = "terraform";
                publisher = "HashiCorp";
                version = "2.30.2024042211";
                sha256 = "79ZrLf8Jzpxn6RUz+mPqf9R/V4RQmInJtQtjNX7j/nM=";
            }
            {
                name = "vscode-edit-csv";
                publisher = "janisdd";
                version = "0.9.1";
                sha256 = "5Xc0X0acECR5Inmwg25gQZbdbSP6PJ+VF3oakNN/Syw=";
            }
            {
                name = "VS-code-vagrantfile";
                publisher = "marcostazi";
                version = "0.0.7";
                sha256 = "78O3Mt2zSgyTI1K92JqUcT86QVLLZZDcqym4/xDT7VY=";
            }
            {
                name = "vscode-pets";
                publisher = "tonybaloney";
                version = "1.25.1";
                sha256 = "as3e2LzKBSsiGs/UGIZ06XqbLh37irDUaCzslqITEJQ=";
            }
        ];
    };
}