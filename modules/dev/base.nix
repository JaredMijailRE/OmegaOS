{ config, pkgs, ... }:

{
  # Herramientas de desarrollo disponibles para todos los usuarios
  environment.systemPackages = with pkgs; [
    kitty
    git
    neovim

    # Herramientas de red
    networkmanager
    networkmanagerapplet

    # Herramientas multimedia y teclas especiales
    pavucontrol
    brightnessctl
    playerctl
    acpi
    xorg.xev
    wmctrl

    # Herramientas de captura de pantalla
    grim
    slurp
    wl-clipboard
    imagemagick

    # Herramientas para compartir pantalla
    wf-recorder
    obs-studio
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk

    nodejs
    docker
    go
    gcc
    gnumake
    kmod
    util-linux
    linuxHeaders
    python3
    rustup
    cargo
    cargo-audit
    cargo-udeps
  ];
}
