# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/pipewire.nix
      ../../modules/nixos/locale.nix
    ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "marc" = import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    foot
    gammastep
    hyprpaper
    wofi
    # Screenshots
    grim
    slurp
    wl-clipboard
    # Eww
    gtk3
    gtk-layer-shell
    gnome2.pango
    gdk-pixbuf
    libdbusmenu-gtk3
    cairo
    rubyPackages.glib2
    libgcc
    glibc
    rustc
    cargo
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
