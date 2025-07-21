{ pkgs, lib, ... }:

{

  imports = [
    ./cliPrograms/sh.nix
    ./cliPrograms/vim.nix
    ./cliPrograms/git.nix
    ./guiPrograms/foot.nix
    ./guiPrograms/hyprland.nix
    ./guiPrograms/cursor.nix
    ./guiPrograms/rmpc.nix
    ./laptopPrograms/laptopHyprland.nix
  ];

}
