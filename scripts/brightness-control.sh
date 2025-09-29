#!/usr/bin/env bash

# Script para controlar el brillo usando light
LIGHT_DEVICE="sysfs/backlight/auto"

# Función para obtener el brillo actual
get_brightness() {
    light -s "$LIGHT_DEVICE" -G
}

# Función para aumentar el brillo
increase_brightness() {
    light -s "$LIGHT_DEVICE" -A 10
    local current=$(get_brightness)
    echo "Brillo: ${current}%"
}

# Función para disminuir el brillo
decrease_brightness() {
    light -s "$LIGHT_DEVICE" -U 10
    local current=$(get_brightness)
    echo "Brillo: ${current}%"
}

# Función para obtener el porcentaje actual
get_percentage() {
    local current=$(get_brightness)
    echo "${current}%"
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
