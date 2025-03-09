{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    ls="ls --color=auto";
    grep="grep --color=auto";
  };
in
{

 programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
      autoload -U colors && colors
      PS1="%B%{$fg[white]%}[%{$fg[white]%}%n%{$fg[white]%}@%{$fg[white]%}%M %{$fg[white]%}%~%{$fg[white]%}]%{$reset_color%}$%b "

      export PATH=/home/marc/.dotfiles/scripts:$PATH

      bindkey -v
      export KEYTIMEOUT=1
      
      # Bind jk and kj
      
      export KEYTIMEOUT=20
      bindkey -M viins 'jk' vi-cmd-mode
      bindkey -M viins 'kj' vi-cmd-mode
      
      if [ "$(tty)" = "/dev/tty1" ];then
      	exec Hyprland
      fi
    '';
  };

  environment.shells = with pkgs; [ zsh ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

}
