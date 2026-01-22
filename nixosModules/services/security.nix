{ pkgs, ... }:

{

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

}
