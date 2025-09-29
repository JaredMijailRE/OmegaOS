#!/usr/bin/env bash

# Script para captura de pantalla con configuración correcta de Wayland
SCREENSHOT_DIR="$HOME/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Función para captura de área seleccionada
capture_area() {
    local filename="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"
    if grim -g "$(slurp)" "$filename"; then
        notify-send "Captura guardada" "Archivo: $(basename "$filename")"
        echo "Captura guardada: $filename"
    else
        notify-send "Error" "No se pudo tomar la captura"
        echo "Error: No se pudo tomar la captura"
    fi
}

# Función para captura de pantalla completa
capture_full() {
    local filename="$SCREENSHOT_DIR/screenshot-$(date +%Y%m%d-%H%M%S).png"
    if grim "$filename"; then
        notify-send "Captura de pantalla completa guardada" "Archivo: $(basename "$filename")"
        echo "Captura guardada: $filename"
    else
        notify-send "Error" "No se pudo tomar la captura"
        echo "Error: No se pudo tomar la captura"
    fi
}

# Función para captura al portapapeles
capture_clipboard() {
    if grim -g "$(slurp)" - | wl-copy; then
        notify-send "Captura copiada al portapapeles"
        echo "Captura copiada al portapapeles"
    else
        notify-send "Error" "No se pudo copiar la captura"
        echo "Error: No se pudo copiar la captura"
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
