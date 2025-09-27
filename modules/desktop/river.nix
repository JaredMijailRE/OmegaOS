{ config, pkgs, ... }:

{
  # Instalar River
  environment.systemPackages = with pkgs; [
    river
  ];

  # Archivo init de River (bindings y configuración)
  environment.etc."river/init".text = ''
    #!/bin/sh
    # Configuración de River en NixOS

    # Ejemplo: Super+T ejecuta un terminal (ajusta el comando según tu terminal)
    riverctl map normal Super+T spawn kitty
  '';
}
