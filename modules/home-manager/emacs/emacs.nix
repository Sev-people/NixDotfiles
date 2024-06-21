{ ... }

{

  home.file."~/.config/emacs/config.org" = {
    source = config.lib.file.mkOutOfStoreSymlink ../config.org;
  };
  home.file."~/.config/emacs/init.el" = {
    source = config.lib.file.mkOutOfStoreSymlink ../init.el;
  };
  home.file."~/.config/emacs/early-init.el" = {
    source = config.lib.file.mkOutOfStoreSymlink ../early-init.el;
  };

}
