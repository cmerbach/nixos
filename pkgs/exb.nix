{ config, pkgs, lib, ... }:
{
    home.packages = with pkgs; [
        asdf # manage all your runtime versions with one tool
        apache-directory-studio # LDAP browser and directory client
        ctop # top-like interface for container metrics
        docker# build, share, and run container applications
        grafana # open source analytics & monitoring solution for every database
        helm # package manager for kubernetes
        k9s # terminal UI to interact with your Kubernetes clusters
        kubectl # command line tool for communicating with a kubernetes cluster
        kubectx # tool to switch between contexts (clusters) on kubectl faster
        minikube # local kubernetes cluster
        terraform #  infrastructure as code tool
        texliveFull # latex
        vagrant # create and configure lightweight, reproducible, and portable development environments
    ];
}