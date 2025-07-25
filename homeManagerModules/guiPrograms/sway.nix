{ config, pkgs, lib, ... }:

{
  # Enable Sway with XWayland support
  services.wayland.windowManager.sway = {
    enable   = true;
    xwayland = true;
    package  = pkgs.sway;
  };

  # Drop this straight into /etc/sway/config
  environment.etc."sway/config".text = lib.concatStringsSep "\n" [
    #–––––– Globals
    "set \$terminal foot"
    "set \$fileManager ranger"
    "set \$menu emacsclient -cF '((visibility . nil))' -e '(emacs-counsel-launcher)'"
    "set \$mainMod Mod1"

    #–––––– Output
    "output * resolution 1920x1080@74.97"

    #–––––– Autostart
    "exec_always --no-startup-id swww-daemon --format xrgb"
    "exec_always --no-startup-id gammastep -O 2500"
    "exec_always --no-startup-id emacs --daemon --init-directory ~/.dotfiles/emacs"
    "exec_always --no-startup-id bash ~/wallpaper.sh"

    #–––––– Environment
    "setenv XCURSOR_SIZE 24"
    "setenv QT_QPA_PLATFORMTHEME qt5t"

    #–––––– Input
    "input * xkb_layout us,gr"
    "input * xkb_variant altgr-intl,polytonic"
    "input * xkb_options compose:ralt"

    #–––––– Layout
    "workspace_layout dwindle"

    #–––––– Workspaces
    "workspace w[t1]"
    "workspace w[tg1]"
    "workspace f[1]"
    "workspace 2"
    "workspace 1"

    #–––––– Keybindings: core actions
    "bindsym \$mainMod+Shift+I exec \$terminal"
    "bindsym \$mainMod+Shift+C kill"
    "bindsym \$mainMod+Shift+Q exit"
    "bindsym \$mainMod+F exec zen"
    "bindsym \$mainMod+E exec bash em"
    "bindsym \$mainMod+Y exec spotify-launcher"
    "bindsym \$mainMod+D exec discord"
    "bindsym \$mainMod+V floating toggle"
    "bindsym \$mainMod+R exec \$menu"
    "bindsym \$mainMod+Shift+U layout toggle split"
    "bindsym \$mainMod+Shift+X exec grim -g \"\$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-\$(date +%F_%T).png"
    "bindsym \$mainMod+N exec pactl set-sink-volume @DEFAULT_SINK@ -5%"
    "bindsym \$mainMod+M exec pactl set-sink-volume @DEFAULT_SINK@ +5%"
    "bindsym \$mainMod+B exec hyprctl switchxkblayout rk-bluetooth-keyboard next"

    #–––––– Focus movement
    "bindsym \$mainMod+h focus left"
    "bindsym \$mainMod+l focus right"
    "bindsym \$mainMod+k focus up"
    "bindsym \$mainMod+j focus down"

    #–––––– Move windows
    "bindsym \$mainMod+Shift+h move left"
    "bindsym \$mainMod+Shift+l move right"
    "bindsym \$mainMod+Shift+k move up"
    "bindsym \$mainMod+Shift+j move down"

    #–––––– Workspace switching & moving
    # Switch
    "bindsym \$mainMod+1 workspace 1"
    "bindsym \$mainMod+2 workspace 2"
    "bindsym \$mainMod+3 workspace 3"
    "bindsym \$mainMod+4 workspace 4"
    "bindsym \$mainMod+5 workspace 5"
    "bindsym \$mainMod+6 workspace 6"
    "bindsym \$mainMod+7 workspace 7"
    "bindsym \$mainMod+8 workspace 8"
    "bindsym \$mainMod+9 workspace 9"
    # Move
    "bindsym \$mainMod+Shift+1 move container to workspace 1"
    "bindsym \$mainMod+Shift+2 move container to workspace 2"
    "bindsym \$mainMod+Shift+3 move container to workspace 3"
    "bindsym \$mainMod+Shift+4 move container to workspace 4"
    "bindsym \$mainMod+Shift+5 move container to workspace 5"
    "bindsym \$mainMod+Shift+6 move container to workspace 6"
    "bindsym \$mainMod+Shift+7 move container to workspace 7"
    "bindsym \$mainMod+Shift+8 move container to workspace 8"
    "bindsym \$mainMod+Shift+9 move container to workspace 9"

    #–––––– Special workspace “magic”
    "bindsym \$mainMod+S workspace magic"
    "bindsym \$mainMod+Shift+S move container to workspace magic"

    #–––––– Mouse actions
    "bindsym --whole-window \$mainMod+button1 move"
    "bindsym --whole-window \$mainMod+button3 resize"

    #–––––– Window rules
    "for_window [title=\"emacs-run-launcher\"] floating enable, resize set 50 ppt 20 ppt"
  ];
}
