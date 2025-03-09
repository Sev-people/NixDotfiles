{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/pipewire.nix
      ../../modules/nixos/locale.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/terminal.nix
    ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  nix.optimise.automatic = true;

  services.printing.enable = true;

  # Run the GC weekly keeping the 5 most recent generation of each profiles.
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

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

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
