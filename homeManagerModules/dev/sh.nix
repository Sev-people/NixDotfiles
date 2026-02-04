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
    initContent = ''
      autoload -U colors && colors
      PS1="%B%{$fg[white]%}[%{$fg[white]%}%n%{$fg[white]%}@%{$fg[white]%}%M %{$fg[white]%}%~%{$fg[white]%}]%{$reset_color%}$%b "

      export PATH=/home/marc/.dotfiles/scripts:$PATH

      # Set up direnv
      eval "$(direnv hook zsh)"

      if [ "$(tty)" = "/dev/tty1" ];then
      	exec sway
      fi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

}
