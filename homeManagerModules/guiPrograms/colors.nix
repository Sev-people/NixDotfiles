{ config, lib, ... }:

let
  myColors = import ../../hosts/default/colors.nix;
in {
  options.my.colors = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    description = "Custom color palette";
    default = myColors.colors;
  };

  config = { };
}
