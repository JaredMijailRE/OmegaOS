#!/usr/bin/env bash

# Script para inicializar servicios de portal automáticamente en Sway
# Este script se ejecuta cada vez que Sway se inicia o recarga

echo "Iniciando servicios de portal para compartir pantalla..."

# Esperar un poco para que Sway termine de inicializar
sleep 2

# Configurar variables de entorno necesarias
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export XDG_CURRENT_DESKTOP="sway"
export XDG_SESSION_TYPE="wayland"

# Verificar que el socket de Wayland existe
if [ ! -S "/run/user/$(id -u)/$WAYLAND_DISPLAY" ]; then
    echo "ERROR: Socket de Wayland no encontrado: /run/user/$(id -u)/$WAYLAND_DISPLAY"
    exit 1
fi

echo "Socket de Wayland detectado: $WAYLAND_DISPLAY"

# Importar variables a systemd
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

# Matar procesos existentes
pkill -f xdg-desktop-portal-wlr 2>/dev/null || true
pkill -f xdg-desktop-portal 2>/dev/null || true

# Esperar un momento
sleep 1

# Iniciar servicios
systemctl --user start xdg-desktop-portal-wlr
systemctl --user start xdg-desktop-portal

echo "Servicios de portal iniciados correctamente"

# Verificar que funcionan
sleep 2
if systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1; then
    echo "✅ xdg-desktop-portal-wlr: ACTIVO"
else
    echo "❌ xdg-desktop-portal-wlr: FALLÓ"
fi

if systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1; then
    echo "✅ xdg-desktop-portal: ACTIVO" 
else
    echo "❌ xdg-desktop-portal: FALLÓ"
fi
