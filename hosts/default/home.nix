{ config, pkgs, inputs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "marc";
  home.homeDirectory = "/home/marc";

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

  defaultHyprland.enable = true;

  home.packages = with pkgs; [
    #browser
    inputs.zen-browser.packages.${pkgs.system}.default
    chromium
    #terminal
    foot
    htop
    ani-cli
    #editing and coding
    emacs
    zathura
    nodejs_20
    auctex
    (texlive.combine { inherit (texlive) booktabs scheme-medium wrapfig marvosym wasysym capt-of titlesec titling braket pgfplots tikz-3dplot chemfig mhchem; })
    pkgs.zotero_7
    ispell
    lilypond-with-fonts
    #recording and editing
    gnome-sound-recorder
    gparted
    kdePackages.kdenlive
    #music
    rmpc
    #misc
    pulseaudio
    unzip
    ffmpeg
    feh
    aria2
    vlc
    gtk3
    easyeffects
    yt-dlp
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
