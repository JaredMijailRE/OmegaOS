#!/usr/bin/env bash

# Script para iniciar el portal de Wayland
# Ejecutar como usuario turing para acceder a la sesión de Wayland
if [ "$(id -u)" -eq 0 ]; then
    # Si se ejecuta como root, cambiar a usuario turing
    exec sudo -u turing env WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 "$0" "$@"
fi

# Configurar variables de entorno para Wayland
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# Iniciar el portal directamente
/nix/store/kw7z6j9dcjpan9h2dgk0hryl8ca20iwx-xdg-desktop-portal-wlr-0.7.1/libexec/xdg-desktop-portal-wlr &

# Verificar que esté activo
sleep 2
ps aux | grep xdg-desktop-portal-wlr
