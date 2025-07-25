{ config, lib, pkgs, ... }:

let
  myStyle = {
    colors = {
      base00 = "000000e6";
      base01 = "000000";
      regular0 = "2b303b";  # black
      regular1 = "bf616a";  # red
      regular2 = "a3be8c";  # green
      regular3 = "ebcb8b";  # yellow
      regular4 = "8fa1b3";  # blue
      regular5 = "b48ead";  # magenta
      regular6 = "96b5b4";  # cyan
      regular7 = "c0c5ce";  # white
      bright0  = "65737e";  # bright black
      bright1  = "bf616a";  # bright red
      bright2  = "a3be8c";  # bright green
      bright3  = "ebcb8b";  # bright yellow
      bright4  = "8fa1b3";  # bright blue
      bright5  = "b48ead";  # bright magenta
      bright6  = "96b5b4";  # bright cyan
      bright7  = "eff1f5";  # bright white
    };

    font = {
      main = "JetBrainsMono Nerd Font";
      style = "Regular";
      size = 10;
    };
  };
in {
  config = {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  options.my.style = lib.mkOption {
    type = lib.types.attrs;
    description = "Unified style (colors, fonts)";
    default = myStyle;
  };
}
