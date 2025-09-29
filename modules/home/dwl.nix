{ config, pkgs, ... }:

let
  # Leer configuración de DWL desde archivo separado
  dwlConfig = builtins.readFile ../../configs/dwl-config;
in

{
  # Variables de entorno para DWL (Wayland)
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "dwl";
    XDG_SESSION_DESKTOP = "dwl";
    XDG_SESSION_TYPE = "wayland";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  # Configuración de DWL usando archivo separado
  xdg.configFile."dwl/config" = {
    text = dwlConfig;
  };
}
