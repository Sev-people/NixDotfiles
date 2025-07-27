{ pkgs, lib, ... }:

{

  imports = [
    ./apps/foot.nix
    ./apps/rmpc.nix
    ./apps/vim.nix
    ./dev/git.nix
    ./dev/sh.nix
    ./system/ssh.nix
    ./system/style.nix
    ./wm/sway.nix
    ./scripts/scripts.nix
  ];

}
