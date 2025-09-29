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
    spotify
    vscode-fhs    
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

    gemini-cli = {
	enable = true;
    };
  };

  # Variables de entorno básicas del usuario
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    
    # ========================================
    # CONFIGURACIÓN DE WINDOW MANAGER ACTIVO
    # ========================================
    # Para cambiar entre Sway y DWL, modifica estas variables:
    
    # Para Sway (Wayland) - ACTIVO:
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    
    # Para DWL (Wayland) - INACTIVO (descomenta para activar):
    # XDG_CURRENT_DESKTOP = "dwl";
    # XDG_SESSION_DESKTOP = "dwl";
    # XDG_SESSION_TYPE = "wayland";
  };



  # ========================================
  # CONFIGURACIÓN DE WINDOW MANAGER ACTIVO
  # ========================================
  # Las configuraciones de window manager están ahora en módulos separados:
  # - Sway: modules/home/sway-config.nix (ACTIVO)
  # - DWL: modules/home/dwl-config.nix (INACTIVO - descomenta en imports para activar)

  # Configuración de Sway (ACTIVA) - usando archivo externo
  xdg.configFile."sway/config" = {
    source = pkgs.writeText "sway-config" (builtins.readFile "/etc/nixos/configs/sway-config");
  };

  # Configuración de DWL (INACTIVA) - usando archivo externo
  # xdg.configFile."dwl/config" = {
  #   source = pkgs.writeText "dwl-config" (builtins.readFile "/etc/nixos/configs/dwl-config");
  # };

  services = {

  };
}
