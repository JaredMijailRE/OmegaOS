{ config, pkgs, ... }:

{
  # Instalar greetd y agreety
  environment.systemPackages = with pkgs; [
    greetd.agreety
  ];

  # Activar greetd como display manager
  services.greetd = {
    enable = true;

    # Configuración del login por defecto
    settings = {
      default_session = {
        command = "${pkgs.greetd.agreety}/bin/agreety --cmd ${pkgs.river}/bin/river";
        user = "turing";
      };

      # Configuración de terminal
      terminal = {
        vt = 1;
      };
    };
  };

  # Configuración de usuario para greetd
  users.users.turing.extraGroups = [ "greetd" ];
}
