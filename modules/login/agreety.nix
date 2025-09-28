{ config, pkgs, ... }:

{
  # Instalar greetd y agreety
  environment.systemPackages = with pkgs; [
    greetd
  ];

  # Activar greetd como display manager
  services.greetd = {
    enable = true;

    # Configuración del login por defecto
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd ${pkgs.river-classic}/bin/river";
        user = "turing";
      };

      # Configuración de terminal
      terminal = {
        vt = 1;
      };
    };
  };
}
