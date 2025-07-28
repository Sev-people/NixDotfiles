{ pkgs, lib, ... }:

let
  mkScript = { name, path, deps ? [] }: 
    pkgs.writeShellScriptBin name ''
      PATH=${lib.makeBinPath deps}:$PATH
      ${builtins.readFile path}
    '';

  scripts = [
    { name = "em"; path = ./em.sh; }
    { name = "new-project"; path = ./new-project.sh; }
    { name = "flake-update"; path = ./flake-update.sh; }
    { name = "track-add"; path = ./track-add.sh; deps = [ pkgs.python313Packages.eyeD3 ]; }
    { name = "cycle-wallpapers"; path = ./cycle-wallpapers.sh; }
    { name = "bar-status"; path = ./bar-status.sh; deps = [ pkgs.iw pkgs.gnugrep ]; }
  ];
in {
  home.packages = map mkScript scripts;
}
