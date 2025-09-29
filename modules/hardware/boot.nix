{ config, pkgs, ... }:

{
  # Bootloader - GRUB para mejor compatibilidad con Windows
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    configurationLimit = 3;
    timeoutStyle = "menu";
  };
  
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
}