{ config, pkgs, ... }:

{
  xdg.enable = true;

  xdg.desktopEntries.org-protocol = {
    name = "Org Protocol";
    exec = "${config.programs.emacs.package}/bin/emacsclient %u";
    terminal = false;
    mimeType = [ "x-scheme-handler/org-protocol" ];
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
  };
}
