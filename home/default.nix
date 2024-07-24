
{ inputs, unstable, ... }:
{
  
    imports = [
        inputs.home-manager.nixosModules.home-manager
    ];
  
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit unstable; };
    };

    home-manager.users.user =  import ./home.nix;

}