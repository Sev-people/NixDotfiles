{ ... }:

let
  localVars = import ../../local-variables.nix;
in {

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "myserver" = {
        hostname = "default";
        user = "marc";
        identityFile = "~/.ssh/id_ed25519";
      };
      termux = {
        hostname = localVars.termuxIp;
        port = 8022;
        user = "u0_a464";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

}
