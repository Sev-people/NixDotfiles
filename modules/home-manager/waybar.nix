{ ... }:

{

programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
      mainBar = {
	layer = "top";
	modules-left = ["hyprland/workspaces"];
	modules-center = ["custom/date"];
	modules-right = [ "battery" "network" "clock"];
        "hyprland/workspaces" = {
	  persistent-workspaces = {
              "*" = 5;
          };
        };
        "custom/date" = {
	  format = "{}";
	  exec = "date \"+%a %b %d %Y\"";
        };
        clock = {
          format = "{:%H:%M}";
	  timezone = "Europe/Madrid";
        };
        network = {
	  format-wifi = "{essid} ({signalStrength}%) ";
          format-disconnected = "Disconnected ⚠";
          interval = 30;
          max-length = 30;
        };
        battery = {
	    bat = "BAT1";
            states = {
              good = 60;
              warning = 30;
              critical = 10;
            };
              format = "{icon}  {capacity}%";
              format-charging = " {capacity}%";
              format-plugged = " {capacity}%";
              format-alt = "{time} {icon}";
              format-icons = ["" "" "" "" ""];
        };
      };
    };
  };

}
