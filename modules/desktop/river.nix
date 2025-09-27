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

  # Configuración de River
  environment.etc."river/init".text = ''
    #!/bin/sh
    # Configuración de River en NixOS

    # Configurar variables de entorno
    export XDG_CURRENT_DESKTOP=river
    export XDG_SESSION_DESKTOP=river
    export XDG_SESSION_TYPE=wayland

    # Iniciar River
    exec river
  '';
  environment.etc."river/init".mode = "0755";

  # Configuración de River
  environment.etc."river/config".text = ''
    # Configuración de River
    riverctl map normal Super+Q exit
    riverctl map normal Super+Return spawn kitty
    riverctl map normal Super+Space spawn fuzzel
    riverctl map normal Super+Shift+E spawn riverctl spawn "emacsclient -c -a emacs"
    riverctl map normal Super+Shift+Q close

    # Layout
    riverctl map normal Super+J focus-view next
    riverctl map normal Super+K focus-view previous
    riverctl map normal Super+Shift+J swap next
    riverctl map normal Super+Shift+K swap previous

    # Spawn
    riverctl map normal Super+Shift+Return spawn kitty
    riverctl map normal Super+Space spawn fuzzel

    # Float
    riverctl map normal Super+Shift+Space toggle-float
    riverctl map normal Super+F toggle-fullscreen

    # Focus
    riverctl map normal Super+Left focus-output next
    riverctl map normal Super+Right focus-output previous
    riverctl map normal Super+Down focus-view next
    riverctl map normal Super+Up focus-view previous

    # Move
    riverctl map normal Super+Shift+Left move left
    riverctl map normal Super+Shift+Right move right
    riverctl map normal Super+Shift+Down move down
    riverctl map normal Super+Shift+Up move up

    # Resize
    riverctl map normal Super+H resize horizontal -100
    riverctl map normal Super+L resize horizontal +100
    riverctl map normal Super+Shift+H resize vertical -100
    riverctl map normal Super+Shift+L resize vertical +100

    # Layout
    riverctl map normal Super+Up layout rivertile main-ratio -0.05
    riverctl map normal Super+Down layout rivertile main-ratio +0.05
    riverctl map normal Super+Left layout rivertile main-count -1
    riverctl map normal Super+Right layout rivertile main-count +1

    # Declarar mods
    riverctl declare-mode normal
    riverctl declare-mode locked

    # Bloquear pantalla
    riverctl map normal Super+Shift+L enter-mode locked
    riverctl map locked Super+Shift+L enter-mode normal
    riverctl map locked Super+Shift+Q exit

    # Screenshots
    riverctl map normal None Print spawn 'grim -g "$(slurp)" - | wl-copy'
    riverctl map normal Shift+Print spawn 'grim - | wl-copy'
  '';

  # Hacer ejecutable el script de init
  system.activationScripts.riverInit = ''
    chmod +x /etc/river/init
  '';
}
