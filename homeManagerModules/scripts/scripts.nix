{ pkgs, ... }:

let
  em = pkgs.writeShellScriptBin "em" ''
    emacsclient -c -a 'emacs --init-directory ~/.dotfiles/emacs'
  '';
in
{
  home.packages = [ em ];
}
