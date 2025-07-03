{ ... }:

{

  services.xserver = {
    xkb.layout = "us,gr";
    xkb.variant = "altgr-intl,polytonic";
    xkb.options = "grp:alt_shift_toggle,grp_led:caps";
  };

}
