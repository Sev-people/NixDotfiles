{ pkgs, inputs, ... }:

{

  # Path information
  home.username = "marc";
  home.homeDirectory = "/home/marc";

  nixpkgs.config.allowUnfree = true;
  
  home.stateVersion = "23.11"; # You should not change this value, even if you update Home Manager.

  # Packages
  home.packages = with pkgs; [
    # Web Browsers
    inputs.zen-browser.packages.${pkgs.system}.default
    
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
    libvterm # Emacs terminal emulation
    auctex
    (texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        booktabs
        wrapfig
        braket
        pgfplots;
    })
    ispell
    lilypond-with-fonts
    
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

    # Security and password management
    pass
    pinentry-curses
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
