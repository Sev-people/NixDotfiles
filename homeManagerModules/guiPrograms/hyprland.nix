{ config, pkgs, lib, ... }:

{

  options = {
    defaultHyprland.enable =
      lib.mkEnableOption "enables default hyprland";
  };

  config = lib.mkIf config.defaultHyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        monitor=",1920x1080@74.97,auto,auto";
        exec-once = ["swww-daemon --format xrgb" "gammastep -O 2500" "emacs --daemon --init-directory ~/.dotfiles/emacs" "bash wallpaper.sh"];
        "$terminal" = "foot";
        "$fileManager" = "ranger";
        "$menu" = "emacsclient -cF \"((visibility . nil))\" -e \"(emacs-counsel-launcher)\"";
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5t"
        ];
        cursor = {
            enable_hyprcursor = false;
        };
        input = {
            kb_layout = "us,gr";
            kb_variant = "altgr-intl,polytonic";
            kb_options = [
                "compose:ralt"
            ];
        };
        workspace = [
          "w[t1], gapsout:0, gapsin:0"
          "w[tg1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
          "2, on-created-empty:zen"
          "1, on-created-empty:emacsclient -c -a 'emacs --init-directory ~/.dotfiles/emacs' ~/Documents/Work/Agenda.org"
        ];
        general = {
            gaps_in = 7;
            gaps_out = 10;
            border_size = 1;
            layout = "dwindle";
        };
        misc = {
          disable_hyprland_logo = true;
        };
        dwindle = {
            pseudotile = "yes";
            preserve_split = "yes"; # you probably want this
            force_split = 2;
        };
        master = {
            new_on_top = true;
        };
        decoration = {
          rounding = 5; 
          blur = {
            enabled = true;
            size = 2;
            passes = 1;
          };
        };
        animations = {
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        "$mainMod" = "ALT";
        bind = [
          "$mainMod SHIFT, I, exec, $terminal"
          "$mainMod SHIFT, C, killactive,"
          "$mainMod SHIFT, Q, exit,"
          "$mainMod, F, exec, zen"
          "$mainMod, E, exec, bash em"
          "$mainMod, Y, exec, spotify-launcher "
          "$mainMod, D, exec, discord "
          "$mainMod, V, togglefloating, "
          "$mainMod, R, exec, $menu"
          "$mainMod SHIFT, U, togglesplit, # dwindle"
          "$mainMod SHIFT, X, exec, grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png"
          "$mainMod, N, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          "$mainMod, M, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          "$mainMod, B, exec, hyprctl switchxkblayout rk-bluetooth-keyboard next"

          
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          
          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"
          
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        windowrulev2 = [
          "float, title:emacs-run-launcher"
          "size 50% 20%, title:emacs-run-launcher"
          "bordersize 0, floating:0, onworkspace:w[t1]"
          "rounding 0, floating:0, onworkspace:w[t1]"
          "bordersize 0, floating:0, onworkspace:w[tg1]"
          "rounding 0, floating:0, onworkspace:w[tg1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];
      };
    };

    home.packages = with pkgs; [
      gammastep
      swww
      hyprpicker
      grim
      slurp
      wl-clipboard
    ];
  };

}
