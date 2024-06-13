{ config, pkgs, unstable, ... }:
{
    programs.vscode = {
        enable = true;
        package = unstable.pkgs.vscodium;
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
            {
                name = "vscode-dashboard";
                publisher = "kruemelkatze";
                version = "2.6.0";
                sha256 = "vipCGhsAXRTWQAmVV0JMUIdpMWtfCo+ohvQKaP72SZw=";
            }
            {
                name = "quick-sticky-notes";
                publisher = "anilkumarum";
                version = "0.0.3";
                sha256 = "hSZrengm5pLLrylvbCfXec4X7pPkTLkpB+BRSPq51cs=";
            }
            {
                name = "workspace-layout";
                publisher = "lostintangent";
                version = "0.0.7";
                sha256 = "G6EllTEhlS2HYg0dd7letFExVXhzuWZrSn1QdbxMAAU=";
            }
        ];
        userSettings = {
            # ---( Settings )---
            "editor.rulers" = [80];
            "editor.tabSize" = 4;
            "security.workspace.trust.untrustedFiles" = "open";
            # // "cSpell.language" = "en,de,de-DE";
            "editor.insertSpaces" = true;
            "editor.detectIndentation" = false;
            "editor.wordWrap" = "off";
            "editor.showFoldingControls" = "always";
            "editor.foldingStrategy" = "indentation";
            "window.titleBarStyle" = "custom";
            "workbench.colorTheme" = "Visual Studio Dark";
            "workbench.startupEditor" = "none";
            "workbench.colorCustomizations" = {
                "statusBar.noFolderBackground" = "#007acd";
            };
            # ---( Dashboard )---
            "dashboard.storeProjectsInSettings" = true;
            "dashboard.projectData" = [
                {
                    "id" = "nixosl4fv88ym1lwyzd5x5";
                    "groupName" = "Repositories";
                    "projects" = [
                        {
                            "isGitRepo" = true;
                            "id" = "nixos67a4icq0glwyzdwau";
                            "name" = "nixos";
                            "path" = "/home/user/nixos";
                            "color" = "var(--vscode-gitDecoration-untrackedResourceForeground)";
                        }
                        {
                            "isGitRepo" = true;
                            "id" = "cwbnggshgfsdl7lwyzfd5o";
                            "name" = "cwbng";
                            "path" = "/home/user/repos/cwbng";
                            "color" = "violet";
                        }
                        {
                            "isGitRepo" = true;
                            "id" = "automationpipeline4vp60jnk1lwyzfuc4";
                            "name" = "automation-pipeline";
                            "path" = "/home/user/repos/automation-pipeline";
                            "color" = "blue";
                        }
                    ];
                    "collapsed" = false;
                }
            ];
            # ---( LaTeX )---
            # // "latex-workshop.docker.image.latex": "software_texlive",
            # // "latex-workshop.docker.enabled": true,
            "latex-workshop.view.pdf.viewer" = "tab";
            "latex-workshop.latex.outDir" = "./tmp";
            "latex-workshop.latex.autoBuild.run" ="never";
            "latex-workshop.message.warning.show" = false;
            "latex-workshop.latex.tools" = [
                {
                    "name" = "latexmk";
                    "command" = "latexmk";
                    "args" = [
                        "-synctex=1"
                        "-interaction=nonstopmode"
                        "-shell-escape"
                        "-file-line-error"
                        "-pdflatex"
                        "-aux-directory=./tmp"
                        "-output-directory=./tmp"
                        "%DOC%"
                    ];
                }
                {
                    "name" = "pdflatex";
                    "command" = "pdflatex";
                    "args" = [
                        "-synctex=1"
                        "-interaction=nonstopmode"
                        "-shell-escape"
                        "-file-line-error"
                        "-aux-directory=./tmp"
                        "-output-directory=./tmp"
                        "%DOC%"
                    ];
                }
                {
                    "name" = "bibtex";
                    "command" ="bibtex";
                    "args" = [
                        "%DOCFILE%"
                    ];
                }
            ];
            # // "latex-workshop.latex.autoClean.run" = "onBuilt",
            # // "latex-workshop.latex.clean.fileTypes" = [
            # //     "*.post"
            # //     "*.acn"
            # //     "*.acr"
            # //     "*.alg"
            # //     "*.auto"
            # //     "*.aux"
            # //     "*.auxlock"
            # //     "*.bbl"
            # //     "*.bcf"
            # //     "*.blg"
            # //     "*.brf"
            # //     "*.dat"
            # //     "*.dep"
            # //     "*.div"
            # //     "*.dpth"
            # //     "*.fdb_latexmk"
            # //     "*.fls"
            # //     "*.glg"
            # //     "*.glo"
            # //     "*.gls"
            # //     "*gnuplottex-fig*"
            # //     "*.gnuploterrors"
            # //     "*.gz"
            # //     "*.idx"
            # //     "*.ind"
            # //     "*figure*.pdf"
            # //     "*.ist"
            # //     "*.lof"
            # //     "*.log"
            # //     "*.lor"
            # //     "*.lot"
            # //     "*.md5"
            # //     "*.nav"
            # //     "*.out"
            # //     "*.snm"
            # //     "*.toc"
            # //     "*.vrb"
            # //     "*.xml"
            # // ];
            # ---( Other )---
            "markdown-preview-enhanced.mermaidTheme" = "dark";
            "markdown-preview-github-styles.lightTheme" = "dark";
            "markdown-preview-enhanced.previewTheme" = "github-dark.css";
            "todo-tree.highlights.defaultHighlight" = {
                "foreground" = "#1bb107aa";   
            };
            "todo-tree.general.tags" = [
                "BUG"
                "PROGRESS"
                "FIXME"
                "TODO"
            ];
            "todo-tree.highlights.customHighlight" = {
                "BUG" = {
                    "icon" = "bug";
                };
                "PROGRESS" = {
                    "icon" = "tools";
                };
                "FIXME" = {
                    "icon" = "flame";
                };
                    #  "icon" = "x"
                    #  "icon" = "issue-draft"
                    #  "icon": "issue-closed"
            };
        };
        # keybindings = [
            
        # ];
    };
}
