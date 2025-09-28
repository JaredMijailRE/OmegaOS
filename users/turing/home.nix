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

  # Configuración funcional de River
  xdg.configFile."river/init" = {
    text = ''
      #!/bin/sh
      # Configuración funcional de River

      # Configurar nivel de log
      riverctl log-level info

      # Declarar modo normal
      riverctl declare-mode normal

      # Atajos básicos esenciales
      riverctl map normal Super+Q exit
      riverctl map normal Super+Shift+E exit

      # Aplicaciones
      riverctl map normal Super+Return spawn kitty
      riverctl map normal Super+D spawn fuzzel
      riverctl map normal Super+Shift+B spawn zen-browser

      # Navegación de ventanas
      riverctl map normal Super+J focus-view next
      riverctl map normal Super+K focus-view previous
      riverctl map normal Super+Shift+J swap next
      riverctl map normal Super+Shift+K swap previous

      # Cambiar tamaño de ventanas
      riverctl map normal Super+H resize-view left -100
      riverctl map normal Super+L resize-view right -100
      riverctl map normal Super+Shift+H resize-view left +100
      riverctl map normal Super+Shift+L resize-view right +100

      # Mover ventanas
      riverctl map normal Super+Shift+Left move left
      riverctl map normal Super+Shift+Right move right
      riverctl map normal Super+Shift+Up move up
      riverctl map normal Super+Shift+Down move down

      # Cambiar layout
      riverctl map normal Super+Space toggle-float
      riverctl map normal Super+F toggle-fullscreen

      # Tags/Workspaces
      riverctl map normal Super+1 send-to-tags 1
      riverctl map normal Super+2 send-to-tags 2
      riverctl map normal Super+3 send-to-tags 3
      riverctl map normal Super+4 send-to-tags 4
      riverctl map normal Super+5 send-to-tags 5

      riverctl map normal Super+Mod1+1 focus-tags 1
      riverctl map normal Super+Mod1+2 focus-tags 2
      riverctl map normal Super+Mod1+3 focus-tags 3
      riverctl map normal Super+Mod1+4 focus-tags 4
      riverctl map normal Super+Mod1+5 focus-tags 5

      # Configuración de entrada
      riverctl input pointer-accel -0.5
      riverctl input pointer-accel-profile flat

      # Configuración de salida (pantalla)
      riverctl output-layout horizontal

      # Configuración de ventanas
      riverctl set-cursor-warp normal
      riverctl set-focus-follows-cursor normal

      # Configuración de bordes
      riverctl border-width 2
      riverctl border-color-focused 0x458588
      riverctl border-color-unfocused 0x3c3836

      # Configuración de fondo
      riverctl background-color 0x282828

      # Configuración de XWayland
      riverctl xwayland disable
    '';
    executable = true;
  };

  # Configuración de servicios
  services = {
    # No hay servicios específicos del usuario por ahora
  };
}