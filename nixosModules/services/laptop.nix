{ ... }:

{

  options = {
    battery.enable = 
      lib.mkEnableOption "enables battery";
  };

  config = lib.mkIf config.battery.enable {
    services.tlp = {
          enable = true;
          settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    
            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    
            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 80;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 50;
    
           #Optional helps save long term battery health
           START_CHARGE_THRESH_BAT1 = 50;
           STOP_CHARGE_THRESH_BAT1 = 80;

           START_CHARGE_THRESH_BAT0 = 80;
           STOP_CHARGE_THRESH_BAT0 = 90;
          };
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };

}
