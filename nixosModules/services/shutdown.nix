{ ... }:

{

  # Every day @ 21:45 - hibernate
  services.cron.systemCronJobs = [
    "45 21 * * * systemctl hibernate"
  ];

}
