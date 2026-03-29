{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    ls="ls --color=auto";
    grep="grep --color=auto";
    mpv="mpv --no-video -ytdl";
    w3m="w3m \"duckduckgo.com\"";
  };
in
{

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initExtra = ''
    PS1="\[\e[1m\]\[\e[37m\][\u@\h \w]\[\e[0m\]$ "
    
    export PATH=/home/marc/.dotfiles/scripts:$PATH

    eval "$(direnv hook bash)"
    
    if [ "$(tty)" = "/dev/tty1" ];then
       exec sway
    fi
    '';
  };

}
