{ config, pkgs, ... }:

{
  # Instalar River y herramientas de Wayland (disponibles para todos los usuarios)
  environment.systemPackages = with pkgs; [
    river-classic
    wayland
    wl-clipboard
    grim
    slurp
    wf-recorder
  ];

  # La configuración de River se maneja en home-manager a través de xdg.configFile
  # No necesitamos scripts en /etc, River lee directamente desde ~/.config/river/init
}
