{ config, lib, ... }:

with lib;
let
  cfg = config.myCustom.hibernationFix;
in {
  options.myCustom.hibernationFix = {
    enable = mkEnableOption "Enable hibernation fix for PC";
  };
  config = mkIf cfg.enable {
    # Fixes sleep/hibernation issues
    systemd.services.systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd.services.systemd-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd.services.systemd-udev-settle.enable = false;
    boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
  };
}
