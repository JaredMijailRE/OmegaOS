{ config, pkgs, ... }:

{
  # Instalar greetd y tuigreet
  environment.systemPackages = with pkgs; [
    tuigreet
    sway
  ];

  # Crear archivos .desktop para las sesiones
      environment.etc."xdg/wayland-sessions/sway.desktop" = {
        text = ''
          [Desktop Entry]
          Name=Sway
          Comment=Sway Wayland Compositor
          Exec=env XDG_SESSION_TYPE=wayland XDG_CURRENT_DESKTOP=sway ${pkgs.sway}/bin/sway
          Type=Application
        '';
      };


  environment.etc."xdg/wayland-sessions/console.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Console
      Comment=Simple Console Session
      Exec=${pkgs.writeShellScript "console-session" ''
        echo "Sesión de consola iniciada"
        echo "Presiona Ctrl+D para salir"
        exec ${pkgs.bash}/bin/bash --login
      ''}
      Type=Application
    '';
  };

  # Activar greetd como display manager
  services.greetd = {
    enable = true;

    # Configuración con tuigreet y menú de selección
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions /etc/xdg/wayland-sessions --remember --remember-user-session --user-menu --window-padding 5 --asterisks";
        user = "turing";
      };

      # Configuración de terminal
      terminal = {
        vt = 1;
      };
    };
  };
}
