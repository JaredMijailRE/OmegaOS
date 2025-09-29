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
}
