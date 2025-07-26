{ pkgs, lib, ... }:

{

  imports = [
    ./programs/zsh.nix
    ./programs/ssh.nix
    ./programs/sway.nix
    ./services/bluetooth.nix
    ./services/maintenance.nix
    ./services/pipewire.nix
    ./services/network.nix
    ./services/printing.nix
    ./services/locale.nix
    ./services/battery.nix
    ./modules/users.nix
    ./modules/bootloader.nix
  ];

}
