{ pkgs, ... }:

{

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true; 

  environment.shells = with pkgs; [ zsh ];

}
