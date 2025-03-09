{ pkgs, lib, ... }:

{

  imports = [
    ./cliPrograms/sh.nix
    ./cliPrograms/vim.nix
    ./cliPrograms/git.nix
    ./guiPrograms/foot.nix
    ./guiPrograms/waybar.nix
    ./guiPrograms/wofi.nix
    ./guiPrograms/hyprland.nix
    ./laptopPrograms/laptopHyprland.nix
  ];

}
