{ config, pkgs, inputs, ... }:

{
  # Configuración de home-manager para el usuario turing
  home.username = "turing";
  home.homeDirectory = "/home/turing";
  
  # Configuración de estado
  home.stateVersion = "25.05";

  # Paquetes de usuario (solo aplicaciones específicas del usuario)
  home.packages = with pkgs; [
    # Herramientas de desarrollo específicas del usuario
    htop
    tree
    curl
    wget
    
    # Aplicaciones específicas del usuario
    inputs.zen-browser.packages.${pkgs.system}.default
    fuzzel
  ];

  # Configuración de programas (configuración específica del usuario)
  programs = {
    # Git - configuración personal del usuario
    git = {
      enable = true;
      userName = "JaredMijailRE";
      userEmail = "jramirezes@unal.edu.co";
    };

    # Bash - configuración personal del usuario
    bash = {
      enable = true;
      enableCompletion = true;
    };

    # Kitty - configuración del terminal
    kitty = {
      enable = true;
      settings = {
        font_family = "JetBrains Mono";
        font_size = 12;
        background_opacity = "0.9";
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
    };
  };

  # Variables de entorno
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen-browser";
    TERMINAL = "kitty";
    XDG_CURRENT_DESKTOP = "river";
    XDG_SESSION_DESKTOP = "river";
    XDG_SESSION_TYPE = "wayland";
  };

  # Configuración de River usando la configuración original
  xdg.configFile."river/init" = {
    text = ''
      #!/bin/sh
      # Configuración de River en NixOS

      # Configurar variables de entorno
      export XDG_CURRENT_DESKTOP=river
      export XDG_SESSION_DESKTOP=river
      export XDG_SESSION_TYPE=wayland

      # Debug: Verificar que riverctl funciona
      riverctl log-level debug

      # Declarar modos primero
      riverctl declare-mode normal
      riverctl declare-mode locked

      # Configuración básica de River - COMANDOS ESENCIALES
      riverctl map normal Super+Q exit
      riverctl map normal Super+T spawn kitty
      riverctl map normal Super+Space spawn fuzzel
      riverctl map normal Super+Z spawn zen-browser
      riverctl map normal Super+Shift+Q close

      # Navegación básica
      riverctl map normal Super+J focus-view next
      riverctl map normal Super+K focus-view previous

      # Float y fullscreen
      riverctl map normal Super+Shift+Space toggle-float
      riverctl map normal Super+F toggle-fullscreen

      # Layout básico (usando layout por defecto de River)
      riverctl map normal Super+Up layout rivertile main-ratio -0.05
      riverctl map normal Super+Down layout rivertile main-ratio +0.05

      # Bloquear pantalla
      riverctl map normal Super+Shift+L enter-mode locked
      riverctl map locked Super+Shift+L enter-mode normal
      riverctl map locked Super+Shift+Q exit

      # Screenshots
      riverctl map normal None Print spawn 'grim -g "$(slurp)" - | wl-copy'
      riverctl map normal Shift+Print spawn 'grim - | wl-copy'
    '';
    executable = true;
  };

  # Configuración de servicios
  services = {
    # No hay servicios específicos del usuario por ahora
  };
}