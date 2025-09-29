{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configuración adicional para arranque dual con Windows
  boot.loader.systemd-boot.configurationLimit = 3;
  
  # Detectar automáticamente otros sistemas operativos
  boot.loader.systemd-boot.editor = false;
}