{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/sh.nix
    ../../modules/home-manager/foot.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/wofi.nix
    ../../modules/home-manager/vim.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "marc";
  home.homeDirectory = "/home/marc";
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    #apps
    discord
    chromium
    xournalpp
    krita
    kdenlive
    rnote
    inkscape-with-extensions
    albert
    #browsers
    firefox-wayland
    #editors
    emacs
    #wm
    waybar
    wofi
    ranger
    gammastep
    ags
    swww
    hyprpicker
    #terminal
    foot
    ani-cli
    htop
    tmux
    #screenshots
    grim
    slurp
    wl-clipboard
    #misc
    git
    zathura
    nodejs_20
    (texlive.combine { inherit (texlive) scheme-medium wrapfig marvosym wasysym capt-of titlesec titling braket pgfplots; })
    auctex
    pkgs.zotero_7
    ispell
    unzip
    ffmpeg
    feh
    aria2
    vlc
    cairo
    pango
    python3
    python312Packages.pip 
    python312Packages.manim 
    python312Packages.matplotlib
    python312Packages.numpy
    gnome-sound-recorder
    gparted
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/marc/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
