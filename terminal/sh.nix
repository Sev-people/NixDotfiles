{ config, lib, pkgs }:
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

      bindkey -v
      export KEYTIMEOUT=1
      
      # Change cursor shape for different vi modes.
      function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
           [[ $1 = 'block' ]]; then
          echo -ne '\e[1 q'
        elif [[ ${KEYMAP} == main ]] ||
             [[ ${KEYMAP} == viins ]] ||
             [[ ${KEYMAP} = '' ]] ||
             [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
        fi
       }

      zle -N zle-keymap-select
      zle-line-init() {
          zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
      
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
