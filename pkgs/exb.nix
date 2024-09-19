{ config, pkgs, lib, unstable, ... }:
{
    home.packages = with pkgs; [
        asdf # manage all your runtime versions with one tool
        apache-directory-studio # LDAP browser and directory client
        awscli2 # unified tool to manage your aws services
        cdrkit # portable command-line cd/dvd recorder software, mostly compatible with cdrtools
        ctop # top-like interface for container metrics
        direnv # shell extension that manages your environment
        docker # build, share, and run container applications
        gnumake # control the generation of non-source files from sources
        grafana # open source analytics & monitoring solution for every database
        helmfile # declarative spec for deploying Helm charts
        jq # lightweight and flexible cli json processor
        kubernetes-helm # package manager for kubernetes
        k9s # terminal UI to interact with your Kubernetes clusters
        kubectl # command line tool for communicating with a kubernetes cluster
        kubectx # tool to switch between contexts (clusters) on kubectl faster
        minikube # local kubernetes cluster
        pick # fuzzy text selection utility
        poetry # python dependency and packaging management
        unstable.pre-commit # framework for managing and maintaining multi-language pre-commit hooks
            unstable.rustc # safe, concurrent, practical language
            unstable.ruff # extremely fast Python linter
            libgcc # GNU compiler collection
            tflint # terraform linter
        rustdesk # remote access and remote control software
        terraform #  infrastructure as code tool
        texliveFull # latex
        vagrant # create and configure lightweight, reproducible, and portable development environments
    ];
}
