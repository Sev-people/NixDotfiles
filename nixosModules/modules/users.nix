{ pkgs, ... }:

{
  
  users.users.marc = {
    isNormalUser = true;
    description = "Marc";
    extraGroups = [ "networkmanager" "audio" "wheel" ];
    shell = pkgs.bash;
  };

}
