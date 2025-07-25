{ pkgs, lib, ... }:

{

  imports = [
    ./cliPrograms/sh.nix
    ./cliPrograms/vim.nix
    ./cliPrograms/git.nix
    ./guiPrograms/foot.nix
    ./guiPrograms/sway.nix
    ./guiPrograms/cursor.nix
    ./guiPrograms/colors.nix
    ./guiPrograms/rmpc.nix
    ./laptopPrograms/laptopHyprland.nix
  ];

}
