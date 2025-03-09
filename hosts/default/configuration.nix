{ config, pkgs, inputs, ... }:

{

  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/pipewire.nix
      ../../modules/nixos/locale.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/programs.nix
      ../../modules/nixos/maintenance.nix
    ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "marc" = import ./home.nix;
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
