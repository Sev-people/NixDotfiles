{ ... }:

{

  programs.vim = {
    enable = true;
    extraConfig = ''
      set nocompatible

      filetype on
       
      set cursorline
      set cursorcolumn
       
      set ignorecase
      set smartcase
       
      colorscheme habamax
       
      :set number
       
      :syntax on
       
      imap jk <Esc>
      imap kj <Esc>
    '';
  };

}
