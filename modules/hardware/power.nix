{ config, pkgs, ... }:

{
  # Herramientas de monitoreo de energía
  environment.systemPackages = with pkgs; [
    powertop
    tlp
  ];

  # Configuración de TLP para ahorro de energía básico
  services.tlp = {
    enable = true;
    settings = {
      # Configuración básica de CPU
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # Configuración de CPU para Intel
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      
      # Configuración de GPU
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      
      # Configuración de PCIe
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";
      
      # Configuración de WiFi
      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";
      
      # Configuración de USB
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_PHONE = 1;
      
      # Configuración de disco
      DISK_DEVICES = "nvme0n1";
      DISK_APM_LEVEL_ON_AC = "254";
      DISK_APM_LEVEL_ON_BAT = "128";
      DISK_SPINDOWN_TIMEOUT_ON_AC = "0";
      DISK_SPINDOWN_TIMEOUT_ON_BAT = "1";
      
      # Configuración de audio
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
    };
  };

  # Configuración de power-profiles-daemon (alternativa moderna)
  services.power-profiles-daemon.enable = true;

  # Configuración de systemd para ahorro de energía
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  # Configuración de suspend/hibernate
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
    lidSwitchDocked = "ignore";
  };

  # Configuración de kernel para ahorro de energía
  boot.kernelParams = [
    "acpi_osi=Linux"
    "acpi_backlight=vendor"
    "acpi_handle_reboot"
  ];
}
