{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        asdf # manage all your runtime versions with one tool
        apache-directory-studio # LDAP browser and directory client
        ctop # top-like interface for container metrics
        direnv # shell extension that manages your environment
        docker # build, share, and run container applications
        gnumake # control the generation of non-source files from sources
        grafana # open source analytics & monitoring solution for every database
        kubernetes-helm # package manager for kubernetes
        k9s # terminal UI to interact with your Kubernetes clusters
        kubectl # command line tool for communicating with a kubernetes cluster
        kubectx # tool to switch between contexts (clusters) on kubectl faster
        minikube # local kubernetes cluster
        poetry # python dependency and packaging management
        pre-commit # framework for managing and maintaining multi-language pre-commit hooks
            rustc # safe, concurrent, practical language
            ruff # extremely fast Python linter
            gcc_multi # GNU compiler collection
            tflint # terraform linter
        
# python3.withPackages (python-pkgs: [python-pkgs.identify])

        slack # web-based instant messaging service
        terraform #  infrastructure as code tool
        texliveFull # latex
        vagrant # create and configure lightweight, reproducible, and portable development environments
    ];
}