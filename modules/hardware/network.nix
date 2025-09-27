{ config, pkgs, ... }:
{
    networking.hostName = "sigmaTuring"; 
    networking.networkmanager.enable = true;
}