{ ... }:

{

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

}
