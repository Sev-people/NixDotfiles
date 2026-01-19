{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    # Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # System
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/default/configuration.nix
          ./nixosModules
          inputs.home-manager.nixosModules.default
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/laptop/configuration.nix
          ./nixosModules
          inputs.home-manager.nixosModules.default
        ];
      };
    };

    homeManagerModules.default = ./homeManagerModules;
  };
}
