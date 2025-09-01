{ pkgs, inputs, ... }:

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ROBLOX
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
  # ALSO REMOVE PKGS
  # ROBLOX

}
