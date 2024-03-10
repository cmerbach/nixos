{
    description = "A very basic flake";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
        disko.url = "github:nix-community/disko";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: {
        nixosConfigurations.full = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                disko.nixosModules.disko
                ./disko.nix
                ./configuration.nix 
                ./home
            ];
        };

        nixosConfigurations.minimal = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                disko.nixosModules.disko
                ./disko.nix
                ./minimal.nix 
            ];
        };

        nixosConfigurations.ceph = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                disko.nixosModules.disko
                ./disko.nix
                ./ceph.nix 
            ];
        };
    };
}