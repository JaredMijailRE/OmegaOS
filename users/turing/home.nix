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
  };

  # Variables de entorno
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
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
    executable = true;
  };

  # Configuración de servicios
  services = {
    # No hay servicios específicos del usuario por ahora
  };
}