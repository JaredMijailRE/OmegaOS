{ config, pkgs, ... }:

{
  # Instalar DWL y herramientas de Wayland
  environment.systemPackages = with pkgs; [
    dwl
    fuzzel
    kitty
    firefox
  ];

  # DWL es un compositor de Wayland, no necesita configuración de X11
  # Solo necesita los paquetes del sistema
}


