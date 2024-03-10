
{ inputs, ... }:
{
  
    imports = [
        inputs.home-manager.nixosModules.home-manager
    ];
  
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
    };

    home-manager.users.user =  import ./home.nix;

}