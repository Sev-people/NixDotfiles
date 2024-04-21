{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    ls="ls --color=auto";
    grep="grep --color=auto";
    vim="vim -u ~/.config/vim/.vimrc";
    svim="sudo vim -u ~/.config/vim/.vimrc";
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
      PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

      export PATH=/home/marc/.config/scripts:$PATH

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

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

}
