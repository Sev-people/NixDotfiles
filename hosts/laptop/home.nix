{ config, pkgs, inputs, ... }:

let
  womicAppImage = builtins.fetchurl {
    url = "https://wolicheng.com/womic/softwares/micclient-x86_64.AppImage";
    sha256 = "1fqxgqjvwiqjzprfvrx9d88hrybrhgww353b4amcp7fn063ch3pa";
  };
in {

  # Path information
  home.username = "marc";
  home.homeDirectory = "/home/marc";

  nixpkgs.config.allowUnfree = true;
  
  home.stateVersion = "23.11"; # You should not change this value, even if you update Home Manager.

  # Packages
  home.packages = with pkgs; [
    # Web Browsers
    inputs.zen-browser.packages.${pkgs.system}.default
    chromium
    
    # Terminal and CLI Tools
    foot
    htop
    fzf
    rsync
    wget
    aria2
    unp
    
    # Development Tools and Programming Environments
    emacs
    
    # PDF and Document Viewers
    zathura
    
    # Multimedia and Media Editing
    ffmpeg
    vlc
    mpv
    
    # System Utilities and Maintenance
    gparted
    pulseaudio
    unzip
    jmtpfs
    gtk3
    feh
    pastel
    yt-dlp
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
