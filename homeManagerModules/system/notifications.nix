{ config, ... }:

let
  style = config.my.style;
in {

  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        transparency = 10;
        font = "${style.font.main} ${toString (style.font.size)}";
      };
    
      urgency_normal = {
        timeout = 10;
      };
    };
  };

}
