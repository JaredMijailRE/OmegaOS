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

  # Configuración de servicios
  services = {
    # No hay servicios específicos del usuario por ahora
  };
}