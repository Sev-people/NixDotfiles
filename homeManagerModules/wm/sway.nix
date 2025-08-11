{ config, pkgs, lib, ... }:

let
  style = config.my.style;
in {

  # Enable Sway under Home Manager’s “Wayland” namespace
  wayland.windowManager.sway = {
    enable = true;

    config = {
      #–––––– Core
      modifier    = "Mod1";                     # ALT
      terminal    = "foot";
      
      #–––––– Autostart
      startup = [
        { command = "swww-daemon --format xrgb"; }
        { command = "gammastep -O 2500"; }
        { command = "emacs --daemon --init-directory ~/.dotfiles/emacs"; }
        { command = "cycle-wallpapers"; }
      ];

      #–––––– Input
      input = {
        "type:keyboard" = {
          xkb_layout  = "us,gr";
          xkb_variant = "altgr-intl,polytonic";
          xkb_options = "grp:win_space_toggle,compose:ralt";
        };
      };

      bars = [
        {
          position = "top";
          statusCommand = "bar-status";
          fonts = {
            names = [ style.font.main ];
            style = style.font.style;
            size = style.font.size + 0.0;
          };
          colors = {
            focusedWorkspace = {
              border = "#${style.colors.base00}";
              background = "#${style.colors.base00}";
              text = "#${style.colors.bright7}";
            };
            activeWorkspace = {
              border = "#${style.colors.base00}";
              background = "#${style.colors.base00}";
              text = "#${style.colors.bright7}";
            };
            inactiveWorkspace = {
              border     = "#${style.colors.base00}";
              background = "#${style.colors.base00}";
              text       = "#${style.colors.regular7}";
            };
            statusline = "#${style.colors.bright7}";
            background = "#${style.colors.base00}";
          }; 
        }
      ];

      #–––––– Keybindings
      keybindings = {
        "Mod1+Shift+I" = "exec foot";
        "Mod1+Shift+C" = "kill";
        "Mod1+Shift+Q" = "exit";

        "Mod1+F"      = "exec zen";
        "Mod1+E"      = "exec em";
        "Mod1+R"      = "exec inbox-capture";
        "Mod1+V"      = "floating toggle";
        "Mod1+Shift+U" = "gaps inner current toggle 15";
        "Mod1+U" = "splith";
        "Mod1+I" = "splitv";
        "Mod1+Shift+X" = "exec grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png";
        "Mod1+N"      = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "Mod1+M"      = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";

        # focus
        "Mod1+h"      = "focus left";
        "Mod1+l"      = "focus right";
        "Mod1+k"      = "focus up";
        "Mod1+j"      = "focus down";

        # move
        "Mod1+Shift+h" = "move left";
        "Mod1+Shift+l" = "move right";
        "Mod1+Shift+k" = "move up";
        "Mod1+Shift+j" = "move down";

        # workspaces
        "Mod1+1"      = "workspace 1";    "Mod1+Shift+1" = "move container to workspace 1";
        "Mod1+2"      = "workspace 2";    "Mod1+Shift+2" = "move container to workspace 2";
        "Mod1+3"      = "workspace 3";    "Mod1+Shift+3" = "move container to workspace 3";
        "Mod1+4"      = "workspace 4";    "Mod1+Shift+4" = "move container to workspace 4";
        "Mod1+5"      = "workspace 5";    "Mod1+Shift+5" = "move container to workspace 5";
        "Mod1+6"      = "workspace 6";    "Mod1+Shift+6" = "move container to workspace 6";
        "Mod1+7"      = "workspace 7";    "Mod1+Shift+7" = "move container to workspace 7";
        "Mod1+8"      = "workspace 8";    "Mod1+Shift+8" = "move container to workspace 8";
        "Mod1+9"      = "workspace 9";    "Mod1+Shift+9" = "move container to workspace 9";

        # special
        "Mod1+S"      = "workspace magic";
        "Mod1+Shift+S" = "move container to workspace magic";
      };
    };
    
    extraConfig = ''
      default_border pixel 1
      hide_edge_borders smart
      client.focused #${style.colors.bright7} #${style.colors.bright7} #${style.colors.bright7} #${style.colors.bright7} #${style.colors.bright7}
    '';
  };
  
  home.sessionVariables = {
    XCURSOR_SIZE           = "24";
    QT_QPA_PLATFORMTHEME   = "qt5t";
  };


  home.packages = with pkgs; [
    gammastep
    grim
    slurp
    wl-clipboard
    swww
  ];

}
