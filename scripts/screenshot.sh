#!/usr/bin/env bash

# Script para captura de pantalla con configuración correcta de Wayland
# Ejecutar como usuario turing para acceder a la sesión de Wayland
if [ "$(id -u)" -eq 0 ]; then
    # Si se ejecuta como root, cambiar a usuario turing
    exec sudo -u turing env WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 "$0" "$@"
fi

SCREENSHOT_DIR="$HOME/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Configurar variables de entorno de Wayland
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# Función para captura de área seleccionada
capture_area() {
    local filename="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"
    if grim -g "$(slurp)" "$filename"; then
        echo "Captura guardada: $filename"
        # Intentar notificación, pero no fallar si no funciona
        notify-send "Captura guardada" "Archivo: $(basename "$filename")" 2>/dev/null || true
    else
        echo "Error: No se pudo tomar la captura"
        # Intentar notificación de error, pero no fallar si no funciona
        notify-send "Error" "No se pudo tomar la captura" 2>/dev/null || true
    fi
}

# Función para captura de pantalla completa
capture_full() {
    local filename="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"
    if grim "$filename"; then
        echo "Captura guardada: $filename"
        # Intentar notificación, pero no fallar si no funciona
        notify-send "Captura de pantalla completa guardada" "Archivo: $(basename "$filename")" 2>/dev/null || true
    else
        echo "Error: No se pudo tomar la captura"
        # Intentar notificación de error, pero no fallar si no funciona
        notify-send "Error" "No se pudo tomar la captura" 2>/dev/null || true
    fi
}

# Función para captura al portapapeles
capture_clipboard() {
    if grim -g "$(slurp)" - | wl-copy; then
        echo "Captura copiada al portapapeles"
        # Intentar notificación, pero no fallar si no funciona
        notify-send "Captura copiada al portapapeles" 2>/dev/null || true
    else
        echo "Error: No se pudo copiar la captura"
        # Intentar notificación de error, pero no fallar si no funciona
        notify-send "Error" "No se pudo copiar la captura" 2>/dev/null || true
    fi
}

# Procesar argumentos
case "$1" in
    "area"|"select")
        capture_area
        ;;
    "full"|"screen")
        capture_full
        ;;
    "clipboard"|"copy")
        capture_clipboard
        ;;
    *)
        echo "Uso: $0 {area|full|clipboard}"
        echo "  area/select : Captura de área seleccionada"
        echo "  full/screen : Captura de pantalla completa"
        echo "  clipboard/copy : Captura al portapapeles"
        exit 1
        ;;
esac
