{

  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
   let
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
          modules = [
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
            {
	      home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.marc = import ./hosts/default/home.nix;
	    }
          ];
        };
      };
    };

}
