{ config, ... }:

let
  style = config.my.style;
in {

  home.file.".config/foot/foot.ini" = {
    text = ''
      font=${style.font.main}:size=${toString style.font.size}
      pad=15x6
      [colors]
      background=${style.colors.base01}
      foreground=${style.colors.regular7}
      alpha=0.8

      regular0=${style.colors.regular0}  # black
      regular1=${style.colors.regular1}  # red
      regular2=${style.colors.regular2}  # green
      regular3=${style.colors.regular3}  # yellow
      regular4=${style.colors.regular4}  # blue
      regular5=${style.colors.regular5}  # magenta
      regular6=${style.colors.regular6}  # cyan
      regular7=${style.colors.regular7}  # white
              
      bright0=${style.colors.bright0}   # bright black
      bright1=${style.colors.bright1}   # bright red
      bright2=${style.colors.bright2}   # bright green
      bright3=${style.colors.bright3}   # bright yellow
      bright4=${style.colors.bright4}   # bright blue
      bright5=${style.colors.bright5}   # bright magenta
      bright6=${style.colors.bright6}   # bright cyan
      bright7=${style.colors.bright7}   # bright white
    '';
  };

}
