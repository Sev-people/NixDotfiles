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
    foot # Terminal
    htop # PC status
    ani-cli # Anime
    wget
    aria2 # Torrents
    ledger # Finances
    
    # Development
    emacs
    ispell # Spelling in Emacs
    # LaTeX
    (pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-small
      dvisvgm mylatexformat preview; # for preview and export as html
    })
    gnuplot
    # Rust
    gcc
    rustc

    # Multimedia
    mupdf # PDF viewer
    ffmpeg
    vlc
    mpv # Music player
    
    # System Utilities
    gparted # Disk partitioning
    pulseaudio
    unzip
    gtk3
    yt-dlp

    # Security and Password Management
    pass # Password manager
    pinentry-curses # Password input (necessary for pass)
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}
