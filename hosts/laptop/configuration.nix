{ config, pkgs, inputs, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "marc" = {
        imports = [
          ./home.nix
          inputs.self.outputs.homeManagerModules.default 
        ];
      };
    };
  };

  laptop.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
