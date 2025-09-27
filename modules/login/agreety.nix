{ config, pkgs, ... }:

{
  # Instalar greetd y agreety
  environment.systemPackages = with pkgs; [
    greetd.agreety  # Agrega agreety (ya viene con greetd)
  ];

  # Activar greetd como display manager
  services.greetd = {
    enable = true;

    # Configuración del login por defecto
    settings = {
      default_session = {
        command = "${pkgs.greetd.agreety}/bin/agreety --cmd ${pkgs.river}/bin/river";
        user = "turing"; # o tu usuario si quieres auto-login
      };

      # Si quieres que greetd use la terminal VT1
      terminal = {
        vt = 1;
      };
    };
  };
}
