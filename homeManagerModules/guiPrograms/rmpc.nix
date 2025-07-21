{ pkgs, ... }:

{

  programs.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };

  home.packages = with pkgs; [
    rmpc
  ];

}
