{ ... }:

{

  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

}
