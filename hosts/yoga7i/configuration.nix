# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/hardware/boot.nix
      ../../modules/hardware/network.nix
#      ../../modules/hardware/power.nix
      ../../modules/desktop/river.nix
      ../../modules/dev/base.nix
#      ../../modules/login/agreety.nix
    ];


  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configuración adicional del sistema
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Configuración de seguridad
  security.sudo.wheelNeedsPassword = false;

  # Configuración de servicios
  services = {
    # SSH
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;  # Habilitar autenticación por contraseña temporalmente
        PubkeyAuthentication = true;     # También permitir claves SSH
      };
    };

    # Printing (opcional)
    printing.enable = false;

    # Bluetooth (opcional)
#    hardware.bluetooth.enable = true;
#   services.blueman.enable = true;
  };

  # Configuración de hardware
  hardware = {
  #   # Audio
  #   pulseaudio.enable = false;
  #   pipewire = {
  #     enable = true;
  #     alsa.enable = true;
  #     pulse.enable = true;
  #   };

  #   # Opengl
     graphics.enable = true;
     graphics.enable32Bit = true;
     graphics.extraPackages = with pkgs;
      [
         intel-media-driver
      ];
  };

  # Configuración de usuarios
  users.users.turing = {
    isNormalUser = true;
    description = "turing";
    extraGroups =  ["seat"  "networkmanager" "wheel" "audio" "video" "input" "plugdev" "power" ];
    packages = with pkgs; [];
  };

  # Configuración de sistema
  system.stateVersion = "25.05";

}
