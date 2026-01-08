{ inputs, ... }:

{

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;

  # Required for org-protocol
  xdg.desktopEntries.org-protocol = {
    name = "org-protocol";
    exec = "emacsclient -- %u";
    terminal = false;
    type = "Application";
    categories = ["System"];
    mimeType = ["x-scheme-handler/org-protocol"];
  };

}
