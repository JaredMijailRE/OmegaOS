{ config, pkgs, ... }:

let
  # Leer configuración de Sway desde archivo separado
  swayConfig = builtins.readFile ../../configs/sway-config;
in

{
  # Variables de entorno para Sway
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  # Configuración de Sway usando archivo separado
  xdg.configFile."sway/config" = {
    text = swayConfig;
  };
}