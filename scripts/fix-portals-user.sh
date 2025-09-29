#!/usr/bin/env bash

# Script para ejecutar COMO USUARIO TURING para arreglar portales
# NO ejecutar como root

echo "🔧 Arreglando portales de compartir pantalla..."

# Verificar que no somos root
if [ "$(id -u)" -eq 0 ]; then
    echo "❌ ERROR: Este script debe ejecutarse como usuario normal, NO como root"
    echo "   Ejecuta: /etc/nixos/scripts/fix-portals-user.sh"
    exit 1
fi

# Configurar variables
export WAYLAND_DISPLAY=wayland-1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

echo "🔍 Variables configuradas:"
echo "   WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
echo "   XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP"
echo "   XDG_SESSION_TYPE: $XDG_SESSION_TYPE"

# Importar a systemd
echo "🔄 Importando variables a systemd..."
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

# Parar servicios
echo "🛑 Parando servicios existentes..."
systemctl --user stop xdg-desktop-portal-wlr 2>/dev/null || true
systemctl --user stop xdg-desktop-portal 2>/dev/null || true

# Matar procesos residuales
pkill -f xdg-desktop-portal-wlr 2>/dev/null || true
pkill -f xdg-desktop-portal 2>/dev/null || true

sleep 3

# Iniciar servicios
echo "🚀 Iniciando servicios..."
systemctl --user start xdg-desktop-portal-wlr
systemctl --user start xdg-desktop-portal

sleep 5

# Verificar
echo "🔍 Verificando servicios:"
if systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1; then
    echo "✅ xdg-desktop-portal-wlr: FUNCIONANDO"
else
    echo "❌ xdg-desktop-portal-wlr: FALLÓ"
    echo "Logs:"
    systemctl --user status xdg-desktop-portal-wlr --no-pager -l
fi

if systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1; then
    echo "✅ xdg-desktop-portal: FUNCIONANDO"
else
    echo "❌ xdg-desktop-portal: FALLÓ"
    echo "Logs:"
    systemctl --user status xdg-desktop-portal --no-pager -l
fi

echo ""
echo "🔍 Procesos activos:"
ps aux | grep -E "(xdg-desktop-portal)" | grep -v grep

echo ""
if systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1 && systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1; then
    echo "🎉 ¡ÉXITO! Compartir pantalla debería funcionar ahora."
    echo ""
    echo "📝 Prueba abriendo Google Meet y compartiendo pantalla"
else
    echo "❌ Aún hay problemas. Revisa los logs arriba."
fi
