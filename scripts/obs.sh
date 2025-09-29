#!/usr/bin/env bash

# Script para lanzar OBS Studio con configuración correcta para Wayland
# Ejecutar como usuario turing para acceder a la sesión de Wayland
if [ "$(id -u)" -eq 0 ]; then
    # Si se ejecuta como root, cambiar a usuario turing
    exec sudo -u turing env WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 QT_QPA_PLATFORM=wayland "$0" "$@"
fi

# Configurar variables de entorno para Wayland
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
export QT_QPA_PLATFORM="wayland"

# Lanzar OBS Studio
exec obs "$@"
