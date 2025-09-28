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

  # Configuración mínima de River para diagnosticar problemas
  xdg.configFile."river/init" = {
    text = ''
      #!/bin/sh
      # Configuración mínima de River para debug

      # Crear archivo de log para debug
      echo "River init script ejecutado: $(date)" > /tmp/river-debug.log

      # Log de debug
      riverctl log-level debug

      # Declarar modo normal
      riverctl declare-mode normal

      # SOLO UN COMANDO PARA PROBAR
      riverctl map normal Super+Q exit

      # Si funciona, agregar más comandos uno por uno
      riverctl map normal Super+T spawn kitty

      # Log de que los comandos se configuraron
      echo "Comandos de River configurados: $(date)" >> /tmp/river-debug.log
    '';
    executable = true;
  };

  # Configuración de servicios
  services = {
    # No hay servicios específicos del usuario por ahora
  };
}