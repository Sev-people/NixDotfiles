{ pkgs, ... }:

{

  # Every day @ 21:45 - hibernate
  services.cron.systemCronJobs = [
    "45 21 * * * root ${pkgs.systemd}/bin/systemctl hibernate"
  ];

  # Automatic suspension
  services.logind.settings = {
    Login = {
      IdleAction = "suspend";
      IdleActionSec = "30min";
      HandlePowerKey = "suspend";
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "suspend";
    };
  };

}
