#!/usr/bin/env bash

# Script para habilitar compartir pantalla en Sway/NixOS
# EJECUTAR COMO USUARIO TURING (no como root)

echo "🚀 Habilitando compartir pantalla para Sway..."

# Verificar que no somos root
if [ "$(id -u)" -eq 0 ]; then
    echo "❌ ERROR: No ejecutar como root. Ejecuta como usuario normal:"
    echo "   ./enable-screen-sharing.sh"
    exit 1
fi

# Verificar que estamos en una sesión de Wayland
if [ -z "$WAYLAND_DISPLAY" ]; then
    echo "🔧 Configurando WAYLAND_DISPLAY..."
    
    # Buscar el socket de Wayland disponible
    if [ -S "/run/user/$(id -u)/wayland-1" ]; then
        export WAYLAND_DISPLAY=wayland-1
        echo "✅ WAYLAND_DISPLAY configurado a: wayland-1"
    elif [ -S "/run/user/$(id -u)/wayland-0" ]; then
        export WAYLAND_DISPLAY=wayland-0
        echo "✅ WAYLAND_DISPLAY configurado a: wayland-0"
    else
        echo "❌ ERROR: No se encontró socket de Wayland. ¿Estás ejecutando Sway?"
        echo "   Sockets buscados en: /run/user/$(id -u)/wayland-*"
        ls -la /run/user/$(id -u)/wayland-* 2>/dev/null || echo "   No se encontraron sockets."
        exit 1
    fi
else
    echo "✅ WAYLAND_DISPLAY ya configurado: $WAYLAND_DISPLAY"
fi

# Configurar otras variables importantes
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

echo "🔄 Importando variables de entorno a systemd..."
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

echo "🔄 Actualizando entorno D-Bus..."
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

echo "🛑 Deteniendo servicios de portal existentes..."
systemctl --user stop xdg-desktop-portal-wlr 2>/dev/null || true
systemctl --user stop xdg-desktop-portal 2>/dev/null || true

# Matar procesos residuales
pkill -f xdg-desktop-portal-wlr 2>/dev/null || true
pkill -f xdg-desktop-portal 2>/dev/null || true

echo "⏳ Esperando 3 segundos..."
sleep 3

echo "🚀 Iniciando servicios de portal..."
systemctl --user start xdg-desktop-portal-wlr
systemctl --user start xdg-desktop-portal

echo "⏳ Esperando que los servicios se inicien..."
sleep 5

echo ""
echo "🔍 Estado de los servicios:"
echo "--- xdg-desktop-portal-wlr ---"
if systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1; then
    echo "✅ xdg-desktop-portal-wlr: ACTIVO"
else
    echo "❌ xdg-desktop-portal-wlr: INACTIVO"
    echo "Logs del servicio:"
    systemctl --user status xdg-desktop-portal-wlr --no-pager -l
fi

echo ""
echo "--- xdg-desktop-portal ---"
if systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1; then
    echo "✅ xdg-desktop-portal: ACTIVO"
else
    echo "❌ xdg-desktop-portal: INACTIVO"
    echo "Logs del servicio:"
    systemctl --user status xdg-desktop-portal --no-pager -l
fi

echo ""
echo "🔍 Procesos activos:"
ps aux | grep -E "(xdg-desktop-portal|portal)" | grep -v grep | grep -v bash || echo "❌ No se encontraron procesos de portal"

echo ""
echo "🔍 Variables de entorno:"
echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP" 
echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"

echo ""
if systemctl --user is-active xdg-desktop-portal-wlr >/dev/null 2>&1 && systemctl --user is-active xdg-desktop-portal >/dev/null 2>&1; then
    echo "🎉 ¡ÉXITO! Compartir pantalla debería funcionar ahora."
    echo ""
    echo "📝 Para probar:"
    echo "  1. Abre Google Meet en Firefox"
    echo "  2. Inicia una reunión"
    echo "  3. Haz clic en 'Compartir pantalla'"
    echo "  4. Deberías ver opciones para compartir"
    echo ""
    echo "📝 Para OBS Studio:"
    echo "  1. Abre OBS"
    echo "  2. Agrega fuente > Captura de pantalla (Wayland)"
    echo "  3. Debería aparecer la opción de seleccionar pantalla"
else
    echo "❌ Algo salió mal. Revisa los logs arriba para más detalles."
    echo ""
    echo "🔧 Si persiste el problema, ejecuta:"
    echo "  journalctl --user -u xdg-desktop-portal-wlr -f"
    echo "  (y luego intenta compartir pantalla en otra terminal)"
fi
