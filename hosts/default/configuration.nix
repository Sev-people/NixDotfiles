{ config, pkgs, inputs, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../nixosModules/pipewire.nix
      ../../nixosModules/locale.nix
      ../../nixosModules/bluetooth.nix
      ../../nixosModules/programs.nix
      ../../nixosModules/maintenance.nix
      ../../nixosModules/connectivity.nix
    ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  home-manager."marc" = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      modules = [
        ./home.nix
        inputs.self.outputs.homeManagerModules.default 
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marc = {
    isNormalUser = true;
    description = "Marc M";
    extraGroups = [ "networkmanager" "audio" "wheel" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
