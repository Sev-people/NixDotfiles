{ ... }:

{
  xdg.desktopEntries.org-protocol = {
    name = "org-protocol";
    exec = "emacsclient -- %u";
    terminal = false;
    type = "Application";
    categories = ["System"];
    mimeType = ["x-scheme-handler/org-protocol"];
  };
}
