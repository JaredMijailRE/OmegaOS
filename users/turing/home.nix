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
    BROWSER = "firefox";
    TERMINAL = "kitty";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };

  # Configuración simple de Sway
  xdg.configFile."sway/config" = {
    text = ''
      # Configuración básica de Sway sin efectos

      # Variables de entorno
      set $mod Mod4

      # Modo por defecto
      set $mode default

      # Atajos básicos esenciales
      bindsym $mod+Shift+q exit
      bindsym $mod+Return exec kitty
      bindsym $mod+d exec fuzzel
      bindsym $mod+b exec firefox
      
      # Cerrar aplicaciones
      bindsym $mod+Shift+c kill
      bindsym $mod+q kill

      # Navegación de ventanas
      bindsym $mod+j focus down
      bindsym $mod+k focus up
      bindsym $mod+h focus left
      bindsym $mod+l focus right

      # Mover ventanas
      bindsym $mod+Shift+j move down
      bindsym $mod+Shift+k move up
      bindsym $mod+Shift+h move left
      bindsym $mod+Shift+l move right

      # Cambiar tamaño de ventanas
      bindsym $mod+Shift+Left resize shrink width 10px
      bindsym $mod+Shift+Right resize grow width 10px
      bindsym $mod+Shift+Down resize grow height 10px
      bindsym $mod+Shift+Up resize shrink height 10px

      # Layout
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split
      bindsym $mod+f fullscreen toggle
      bindsym $mod+Shift+space floating toggle

      # Workspaces
      bindsym $mod+1 workspace number 1
      bindsym $mod+2 workspace number 2
      bindsym $mod+3 workspace number 3
      bindsym $mod+4 workspace number 4
      bindsym $mod+5 workspace number 5

      bindsym $mod+Shift+1 move container to workspace number 1
      bindsym $mod+Shift+2 move container to workspace number 2
      bindsym $mod+Shift+3 move container to workspace number 3
      bindsym $mod+Shift+4 move container to workspace number 4
      bindsym $mod+Shift+5 move container to workspace number 5

      # Configuración de ventanas
      default_border pixel 2
      default_floating_border pixel 2
      hide_edge_borders smart

      # Colores simples
      client.focused #458588 #458588 #ffffff #458588
      client.focused_inactive #3c3836 #3c3836 #ffffff #3c3836
      client.unfocused #3c3836 #3c3836 #ffffff #3c3836

      # Configuración de entrada
      input type:keyboard {
        xkb_layout us
        xkb_variant ""
      }

      input type:touchpad {
        tap enabled
        natural_scroll enabled
      }

      # Configuración de salida
      output * bg #000000 solid_color
    '';
  };

  # Configuración de servicios
  services = {
    # No hay servicios específicos del usuario por ahora
  };
}