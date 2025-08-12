{ config, ... }:

let
  style = config.my.style;
in {

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 400;
        height = 100;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = style.colors.base01;
        font = "${style.font.main} ${toString (style.font.size)}";
      };
    
      urgency_normal = {
        background = style.colors.base00;
        foreground = style.colors.regular0;
        timeout = 10;
      };
    };
  };

}
