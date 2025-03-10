{ pkgs, lib, ... }:

{

  imports = [
    ./programs/hyprland.nix
    ./programs/zsh.nix
    ./programs/fonts.nix
    ./services/bluetooth.nix
    ./services/maintenance.nix
    ./services/pipewire.nix
    ./services/network.nix
    ./services/printing.nix
    ./services/locale.nix
    ./services/stylix.nix
    ./services/battery.nix
  ];

}
