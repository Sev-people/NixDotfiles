{ pkgs, ... }:

{

  # Path information
  home.username = "marc";
  home.homeDirectory = "/home/marc";

  nixpkgs.config.allowUnfree = true;
  
  home.stateVersion = "23.11"; # You should not change this value, even if you update Home Manager.
  
  # Packages
  home.packages = with pkgs; [
    # Terminal and CLI Tools
    foot
    htop
    ani-cli
    fzf # Fuzzy search
    ripgrep # Regexp search
    rsync # SSH file transfer
    wget
    aria2 # Torrents
    unp
    
    # Development Tools and Programming Environments
    emacs
    auctex
    ispell
    lilypond-with-fonts
    jq # Terminal JSON utility
    
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

    # Security and Password Management
    pass
    pinentry-curses
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
