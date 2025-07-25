{ ... }:

{

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "myserver" = {
        hostname = "default";
        user = "marc";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

}
