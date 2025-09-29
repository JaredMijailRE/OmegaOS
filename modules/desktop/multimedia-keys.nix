{ config, pkgs, ... }:

{
  # Configuración de teclas multimedia para Sway
  environment.etc."sway/config.d/multimedia-keys.conf" = {
    text = ''
      # Teclas multimedia
      
      # Volumen
      bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
      
      # Micrófono
      bindsym XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
      
      # Brillo
      bindsym XF86MonBrightnessUp exec brightnessctl set +10%
      bindsym XF86MonBrightnessDown exec brightnessctl set 10%-
      
      # Bloqueo de pantalla
      bindsym XF86ScreenSaver exec swaylock
      
      # Modo avión (desactivar/activar WiFi)
      bindsym XF86WLAN exec nmcli radio wifi toggle
      
      # Reproductor multimedia
      bindsym XF86AudioPlay exec playerctl play-pause
      bindsym XF86AudioNext exec playerctl next
      bindsym XF86AudioPrev exec playerctl previous
      
      # Notificaciones de volumen
      bindsym XF86AudioRaiseVolume exec --no-startup-id notify-send "Volumen: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)"
      bindsym XF86AudioLowerVolume exec --no-startup-id notify-send "Volumen: $(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -1)"
      bindsym XF86AudioMute exec --no-startup-id notify-send "Audio $(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')"
      
      # Notificaciones de brillo
      bindsym XF86MonBrightnessUp exec --no-startup-id notify-send "Brillo: $(brightnessctl get)%"
      bindsym XF86MonBrightnessDown exec --no-startup-id notify-send "Brillo: $(brightnessctl get)%"
    '';
  };

  # Configuración de servicios necesarios
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Configuración de hardware para audio
  hardware.pulseaudio.enable = false;
  
  # Configuración de brillo
  programs.light.enable = true;
  
  # Configuración de notificaciones
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrains Mono 10";
        format = "<b>%s</b>\n%b";
        markup = "yes";
        plain_text = "no";
        indicate_hidden = "yes";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "300x5-30+20";
        shrink = "no";
        transparency = 0;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        startup_notification = false;
        dmenu = "/usr/bin/dmenu -p dunst:";
        browser = "/usr/bin/xdg-open";
        title = "Dunst";
        class = "Dunst";
        corner_radius = 0;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
    };
  };
}



