#!/usr/bin/env bash

# Script para controlar el brillo del dispositivo ideapad
BRIGHTNESS_FILE="/sys/class/backlight/ideapad/brightness"
MAX_BRIGHTNESS_FILE="/sys/class/backlight/ideapad/max_brightness"
BL_POWER_FILE="/sys/class/backlight/ideapad/bl_power"

# Función para obtener el brillo actual
get_brightness() {
    cat "$BRIGHTNESS_FILE"
}

# Función para obtener el brillo máximo
get_max_brightness() {
    cat "$MAX_BRIGHTNESS_FILE"
}

# Función para establecer el brillo
set_brightness() {
    local value=$1
    # Asegurar que el backlight esté encendido
    echo "0" | sudo tee "$BL_POWER_FILE" > /dev/null
    echo "$value" | sudo tee "$BRIGHTNESS_FILE" > /dev/null
}

# Función para aumentar el brillo
increase_brightness() {
    local current=$(get_brightness)
    local max=$(get_max_brightness)
    local step=$((max / 10))  # 10% del máximo
    local new=$((current + step))
    
    if [ $new -gt $max ]; then
        new=$max
    fi
    
    set_brightness $new
    echo "Brillo: $((new * 100 / max))%"
}

# Función para disminuir el brillo
decrease_brightness() {
    local current=$(get_brightness)
    local max=$(get_max_brightness)
    local step=$((max / 10))  # 10% del máximo
    local new=$((current - step))
    
    if [ $new -lt 1 ]; then
        new=1
    fi
    
    set_brightness $new
    echo "Brillo: $((new * 100 / max))%"
}

# Función para obtener el porcentaje actual
get_percentage() {
    local current=$(get_brightness)
    local max=$(get_max_brightness)
    echo "$((current * 100 / max))%"
}

# Procesar argumentos
case "$1" in
    "up"|"+"|"increase")
        increase_brightness
        ;;
    "down"|"-"|"decrease")
        decrease_brightness
        ;;
    "get"|"status")
        get_percentage
        ;;
    *)
        echo "Uso: $0 {up|down|get}"
        echo "  up/increase/+ : Aumentar brillo"
        echo "  down/decrease/- : Disminuir brillo"
        echo "  get/status : Obtener brillo actual"
        exit 1
        ;;
esac
