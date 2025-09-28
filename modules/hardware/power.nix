{ config, pkgs, ... }:

{
  # Herramientas básicas de monitoreo de energía
  environment.systemPackages = with pkgs; [
    powertop
  ];

  # Configuración básica de power-profiles-daemon
  services.power-profiles-daemon.enable = true;

  # Configuración básica de systemd para energía
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";  # Balanceado entre rendimiento y energía
  };

  # Configuración básica de suspend/hibernate
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };

  # Parámetros básicos del kernel para compatibilidad
  boot.kernelParams = [
    "acpi_osi=Linux"
    "acpi_backlight=vendor"
  ];
}
