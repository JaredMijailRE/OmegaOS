{ config, pkgs, ... }:

{
  # Paquetes necesarios para multimedia
  environment.systemPackages = with pkgs; [
    pulseaudio # Para pactl
    brightnessctl
    playerctl
    libnotify # Para notify-send
    swaylock
    networkmanager # Para nmcli
  ];

  # Configuración de teclas multimedia para Sway
  environment.etc."sway/config.d/multimedia-keys.conf" = {
    text = ''
      # Teclas multimedia
      
      # Volumen (con notificaciones)
      bindsym XF86AudioRaiseVolume exec --no-startup-id bash -c "pactl set-sink-volume @DEFAULT_SINK@ +5% && notify-send 'Volumen: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)'"
      bindsym XF86AudioLowerVolume exec --no-startup-id bash -c "pactl set-sink-volume @DEFAULT_SINK@ -5% && notify-send 'Volumen: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)'"
      bindsym XF86AudioMute exec --no-startup-id bash -c "pactl set-sink-mute @DEFAULT_SINK@ toggle && notify-send 'Audio $(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')'"
      
      # Micrófono
      bindsym XF86AudioMicMute exec --no-startup-id bash -c "pactl set-source-mute @DEFAULT_SOURCE@ toggle && notify-send 'Micrófono $(pactl get-source-mute @DEFAULT_SOURCE@ | grep -o 'yes\|no')'"
      
      # Brillo (con notificaciones) - usando script personalizado
      bindsym XF86MonBrightnessUp exec --no-startup-id bash -c "/etc/nixos/scripts/brightness-control.sh up && notify-send 'Brillo: $(/etc/nixos/scripts/brightness-control.sh get)'"
      bindsym XF86MonBrightnessDown exec --no-startup-id bash -c "/etc/nixos/scripts/brightness-control.sh down && notify-send 'Brillo: $(/etc/nixos/scripts/brightness-control.sh get)'"
      
      # Bloqueo de pantalla
      bindsym XF86ScreenSaver exec swaylock
      
      # Modo avión (desactivar/activar WiFi)
      bindsym XF86WLAN exec --no-startup-id bash -c "nmcli radio wifi toggle && notify-send 'WiFi $(nmcli radio wifi | grep -o 'enabled\|disabled')'"
      
      # Reproductor multimedia
      bindsym XF86AudioPlay exec --no-startup-id bash -c "playerctl play-pause && notify-send 'Reproductor: $(playerctl status)'"
      bindsym XF86AudioNext exec --no-startup-id bash -c "playerctl next && notify-send 'Siguiente canción'"
      bindsym XF86AudioPrev exec --no-startup-id bash -c "playerctl previous && notify-send 'Canción anterior'"
      
      # Captura de pantalla
      bindsym Print exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym Shift+Print exec --no-startup-id /etc/nixos/scripts/screenshot.sh full
      bindsym Ctrl+Print exec --no-startup-id /etc/nixos/scripts/screenshot.sh area
      
      # Teclas alternativas para captura (sin Fn)
      bindsym XF86Launch1 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch2 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch3 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch4 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch5 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch6 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch7 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch8 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Launch9 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86LaunchA exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86LaunchB exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      
      # Mapeos específicos para teclas de captura
      bindsym XF86Camera exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86Pictures exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym XF86ScreenSaver exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      
      # Mapeo por código de tecla (5;10u)
      bindsym --to-code 107 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym --to-code 108 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym --to-code 109 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
      bindsym --to-code 110 exec --no-startup-id /etc/nixos/scripts/screenshot.sh clipboard
    '';
  };

  # Configuración de servicios necesarios
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Configuración adicional para que Pipewire funcione correctamente
  security.rtkit.enable = true;
  
  # Configuración de usuarios para audio y video
  users.extraUsers.turing.extraGroups = [ "audio" "pipewire" "video" ];

  # Crear directorio de capturas
  systemd.tmpfiles.rules = [
    "d /home/turing/Screenshots 0755 turing users -"
  ];

  # Configuración de hardware para audio
  services.pulseaudio.enable = false;
  
  # Configuración de brillo
  programs.light.enable = true;

  # Configuración mejorada del trackpad
  environment.etc."sway/config.d/trackpad.conf" = {
    text = ''
      # Configuración mejorada del trackpad
      input type:touchpad {
        tap enabled
        natural_scroll enabled
        middle_emulation enabled
        tap_button_map lrm
        scroll_method two_finger
        click_method clickfinger
        accel_profile adaptive
        pointer_accel 0.8
        scroll_factor 1.0
        dwt enabled
        dwtp enabled
        # calibration_matrix removida - causaba error
      }
    '';
  };

  # Configuración de notificaciones - usando environment.etc para dunst
  environment.etc."dunst/dunstrc" = {
    text = ''
      [global]
      font = "JetBrains Mono 10"
      format = "<b>%s</b>\n%b"
      markup = yes
      plain_text = no
      indicate_hidden = yes
      alignment = left
      vertical_alignment = center
      show_age_threshold = 60
      word_wrap = yes
      ignore_newline = no
      geometry = "300x5-30+20"
      shrink = no
      transparency = 0
      idle_threshold = 120
      monitor = 0
      follow = mouse
      sticky_history = yes
      line_height = 0
      separator_height = 2
      padding = 8
      horizontal_padding = 8
      separator_color = frame
      startup_notification = false
      dmenu = "/usr/bin/dmenu -p dunst:"
      browser = "/usr/bin/xdg-open"
      title = "Dunst"
      class = "Dunst"
      corner_radius = 0
      ignore_dbusclose = false
      force_xwayland = false
      force_xinerama = false
      mouse_left_click = close_current
      mouse_middle_click = do_action, close_current
      mouse_right_click = close_all

      [urgency_low]
      background = "#1e1e1e"
      foreground = "#ffffff"
      timeout = 10

      [urgency_normal]
      background = "#285577"
      foreground = "#ffffff"
      timeout = 10

      [urgency_critical]
      background = "#900000"
      foreground = "#ffffff"
      frame_color = "#ff0000"
      timeout = 0
    '';
  };
}
