{ pkgs, lib, ... }:

let
  mkScript = { name, path, deps ? [] }: 
    pkgs.writeShellScriptBin name ''
      PATH=${lib.makeBinPath deps}:$PATH
      ${builtins.readFile path}
    '';

  scripts = [
    { name = "em"; path = ./em.sh; }
    { name = "flake-update"; path = ./flake-update.sh; }
    { name = "cycle-wallpapers"; path = ./cycle-wallpapers.sh; }
    { name = "bar-status"; path = ./bar-status.sh; deps = [ pkgs.iw pkgs.gnugrep ]; }
    { name = "push-files"; path = ./push-files.sh; }
  ];
in {
  home.packages = map mkScript scripts;
}
