{ config, pkgs, ... }:

{
  # Herramientas de desarrollo disponibles para todos los usuarios
  environment.systemPackages = with pkgs; [
    kitty
    git
    neovim

    docker
    go
    python3
    rustup
    cargo
    cargo-audit
    cargo-udeps
  ];
}