{ config, pkgs, lib, ... }:

let
  style = config.my.style;
in {

  # Enable Sway under Home Manager’s “Wayland” namespace
  wayland.windowManager.sway = {
    enable = true;

    config = {
      #–––––– Core
      modifier    = "Mod4";                     # SUPER
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
        "Mod4+Shift+I" = "exec foot";
        "Mod4+Shift+C" = "kill";
        "Mod4+Shift+Q" = "exit";

        "Mod4+F"      = "exec zen";
        "Mod4+E"      = "exec em";
        "Mod4+R"      = "exec emacsclient -c \"org-protocol://capture?template=i\"";
        "Mod4+V"      = "floating toggle";
        "Mod4+Shift+U" = "gaps inner current toggle 15";
        "Mod4+U" = "splith";
        "Mod4+I" = "splitv";
        "Mod4+Shift+X" = "exec grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png";
        "Mod4+N"      = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "Mod4+M"      = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";

        # focus
        "Mod4+h"      = "focus left";
        "Mod4+l"      = "focus right";
        "Mod4+k"      = "focus up";
        "Mod4+j"      = "focus down";

        # move
        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+l" = "move right";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+j" = "move down";

        # workspaces
        "Mod4+1"      = "workspace 1";    "Mod4+Shift+1" = "move container to workspace 1";
        "Mod4+2"      = "workspace 2";    "Mod4+Shift+2" = "move container to workspace 2";
        "Mod4+3"      = "workspace 3";    "Mod4+Shift+3" = "move container to workspace 3";
        "Mod4+4"      = "workspace 4";    "Mod4+Shift+4" = "move container to workspace 4";
        "Mod4+5"      = "workspace 5";    "Mod4+Shift+5" = "move container to workspace 5";
        "Mod4+6"      = "workspace 6";    "Mod4+Shift+6" = "move container to workspace 6";
        "Mod4+7"      = "workspace 7";    "Mod4+Shift+7" = "move container to workspace 7";
        "Mod4+8"      = "workspace 8";    "Mod4+Shift+8" = "move container to workspace 8";
        "Mod4+9"      = "workspace 9";    "Mod4+Shift+9" = "move container to workspace 9";

        # special
        "Mod4+S"      = "workspace magic";
        "Mod4+Shift+S" = "move container to workspace magic";
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
