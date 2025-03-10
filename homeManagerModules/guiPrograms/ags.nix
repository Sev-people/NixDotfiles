{ inputs, pkgs, ... }:

{

  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # symlink to ~/.config/ags
    configDir = null;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
    ];
  };

}
