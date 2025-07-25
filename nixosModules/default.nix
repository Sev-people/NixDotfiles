{ pkgs, lib, ... }:

{

  imports = [
    ./programs/zsh.nix
    ./services/bluetooth.nix
    ./services/maintenance.nix
    ./services/pipewire.nix
    ./services/network.nix
    ./services/printing.nix
    ./services/locale.nix
    ./services/battery.nix
    ./services/security.nix
    ./modules/users.nix
    ./modules/bootloader.nix
  ];

}
