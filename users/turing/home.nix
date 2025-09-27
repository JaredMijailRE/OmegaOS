{ config, pkgs, ... }:

{
  users.users.turing = {
    isNormalUser = true;
    description = "turing";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}