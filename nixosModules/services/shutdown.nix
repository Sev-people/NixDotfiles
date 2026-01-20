{ ... }:

{

  # Every day @ 21:45 - hibernate
  services.cron.systemCronJobs = [
    "45 21 * * * systemctl hibernate"
  ];

  # Automatic suspension
	services.logind.extraConfig = ''
	  IdleAction=suspend
	  IdleActionSec=30min
	  HandlePowerKey=suspend
	  HandleLidSwitch=suspend
	  HandleLidSwitchDocked=suspend
	'';
}
