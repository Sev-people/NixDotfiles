{ ... }:

{

  programs.ssh = {
    enable = true;
    matchBlocks = {
      desktop = {
        hostname = "default";
        user = "marc";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

}
