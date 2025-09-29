{ config, pkgs, ... }:
{
    networking.hostName = "Microvac"; 
    networking.networkmanager.enable = true;
}