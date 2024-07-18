{
    description = "A very basic flake";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
        # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        disko.url = "github:nix-community/disko";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.unstable.follows = "nixpkgs-unstable";
        };
    };

    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, disko, home-manager, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        # Info: https://discourse.nixos.org/t/how-to-allow-unfree-for-unstable-packages/43600/4
        unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
    in {
        nixosConfigurations.full = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs unstable; };
            modules = [
                disko.nixosModules.disko
                ./disko.nix
                ./configuration.nix 
                ./home
            ];
        };

        nixosConfigurations.minimal = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [
                disko.nixosModules.disko
                ./disko.nix
                ./minimal.nix 
            ];
        };
    };
}