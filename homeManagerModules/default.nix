{ pkgs, lib, ... }:

{

  imports = [
    ./apps/foot.nix
    ./apps/rmpc.nix
    ./apps/vim.nix
    ./dev/git.nix
    ./dev/sh.nix
    ./system/ssh.nix
    ./wm/sway.nix
    ./wm/style.nix
    ./scripts/scripts.nix
  ];

}
