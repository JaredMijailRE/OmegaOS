{ config, pkgs, ... }:

{
  # Instalar greetd, tuigreet y sway
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
      Exec=${pkgs.sway}/bin/sway
      Type=Application
      DesktopNames=Sway
    '';
  };

  environment.etc."xdg/wayland-sessions/console.desktop" = {
    text = ''
      [Desktop Entry]
      Name=W-Console
      Comment=Simple Console Session
      Exec=${pkgs.writeShellScript "console-session" ''
        echo "Sesión de consola iniciada"
        echo "Presiona Ctrl+D para salir"
        exec ${pkgs.bash}/bin/bash --login
      ''}
      Type=Application
    '';
  };

  # Activar greetd con tuigreet (Sway por defecto, consola disponible)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions /etc/xdg/wayland-sessions --remember --remember-user-session --user-menu --window-padding 5 --asterisks";
        user = "turing";
      };
      terminal = {
        vt = 1;
      };
    };
  };
}
