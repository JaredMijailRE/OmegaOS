#!/bin/bash

echo "=== Prueba de Teclas Multimedia ==="
echo ""

# Verificar si Pipewire está ejecutándose
echo "1. Verificando estado de Pipewire..."
if systemctl --user is-active --quiet pipewire; then
    echo "   ✅ Pipewire está ejecutándose"
else
    echo "   ❌ Pipewire NO está ejecutándose"
    echo "   Intentando iniciar Pipewire..."
    systemctl --user start pipewire
    sleep 2
    if systemctl --user is-active --quiet pipewire; then
        echo "   ✅ Pipewire iniciado correctamente"
    else
        echo "   ❌ No se pudo iniciar Pipewire"
    fi
fi

echo ""

# Verificar sinks de audio
echo "2. Verificando sinks de audio..."
if command -v pactl >/dev/null 2>&1; then
    sinks=$(pactl list sinks short 2>/dev/null)
    if [ -n "$sinks" ]; then
        echo "   ✅ Sinks de audio encontrados:"
        echo "$sinks" | sed 's/^/      /'
    else
        echo "   ❌ No se encontraron sinks de audio"
    fi
else
    echo "   ❌ pactl no está disponible"
fi

echo ""

# Verificar volumen actual
echo "3. Verificando volumen actual..."
if command -v pactl >/dev/null 2>&1; then
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "   ✅ Volumen actual: $volume"
    else
        echo "   ❌ No se pudo obtener el volumen"
    fi
else
    echo "   ❌ pactl no está disponible"
fi

echo ""

# Verificar herramientas multimedia
echo "4. Verificando herramientas multimedia..."
tools=("brightnessctl" "playerctl" "notify-send" "swaylock")
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "   ✅ $tool está disponible"
    else
        echo "   ❌ $tool NO está disponible"
    fi
done

echo ""

# Verificar configuración de Sway
echo "5. Verificando configuración de Sway..."
if [ -f "/etc/sway/config.d/multimedia-keys.conf" ]; then
    echo "   ✅ Archivo multimedia-keys.conf existe"
    echo "   Contenido del archivo:"
    cat /etc/sway/config.d/multimedia-keys.conf | sed 's/^/      /'
else
    echo "   ❌ Archivo multimedia-keys.conf NO existe"
fi

echo ""

# Verificar configuración del trackpad
echo "6. Verificando configuración del trackpad..."
if [ -f "/etc/sway/config.d/trackpad.conf" ]; then
    echo "   ✅ Archivo trackpad.conf existe"
    echo "   Contenido del archivo:"
    cat /etc/sway/config.d/trackpad.conf | sed 's/^/      /'
else
    echo "   ❌ Archivo trackpad.conf NO existe"
fi

echo ""
echo "=== Instrucciones para probar ==="
echo "1. Reinicia Sway con: swaymsg reload"
echo "2. Prueba las teclas de volumen: Fn+F8, Fn+F9, Fn+F10"
echo "3. Prueba las teclas de brillo: Fn+F5, Fn+F6"
echo "4. Prueba el trackpad para verificar la sensibilidad"
echo ""
echo "Si las teclas no funcionan, ejecuta:"
echo "  swaymsg reload"
echo "  systemctl --user restart pipewire"

