{ config, pkgs, ... }:

{
  # Instalar Sway y herramientas de Wayland
  environment.systemPackages = with pkgs; [
    sway
    wayland
    wl-clipboard
    grim
    slurp
    wf-recorder
    fuzzel
    kitty
    firefox
  ];
}