#!/usr/bin/env bash

echo "=== Prueba de Teclas de Brillo ==="
echo ""

# Verificar si el script de brillo existe y funciona
echo "1. Verificando script de brillo..."
if [ -f "/etc/nixos/scripts/brightness-control.sh" ]; then
    echo "   ✅ Script existe"
    if [ -x "/etc/nixos/scripts/brightness-control.sh" ]; then
        echo "   ✅ Script es ejecutable"
        current_brightness=$(/etc/nixos/scripts/brightness-control.sh get)
        echo "   ✅ Brillo actual: $current_brightness"
    else
        echo "   ❌ Script no es ejecutable"
    fi
else
    echo "   ❌ Script no existe"
fi

echo ""

# Verificar configuración de Sway
echo "2. Verificando configuración de Sway..."
if [ -f "/etc/sway/config.d/multimedia-keys.conf" ]; then
    echo "   ✅ Archivo multimedia-keys.conf existe"
    if grep -q "brightness-control.sh" /etc/sway/config.d/multimedia-keys.conf; then
        echo "   ✅ Configuración de brillo encontrada"
    else
        echo "   ❌ Configuración de brillo NO encontrada"
    fi
else
    echo "   ❌ Archivo multimedia-keys.conf NO existe"
fi

echo ""

# Verificar si Sway está ejecutándose
echo "3. Verificando Sway..."
if pgrep -x "sway" > /dev/null; then
    echo "   ✅ Sway está ejecutándose"
    sway_pid=$(pgrep -x "sway")
    echo "   PID: $sway_pid"
else
    echo "   ❌ Sway NO está ejecutándose"
fi

echo ""

# Probar el script manualmente
echo "4. Probando script manualmente..."
echo "   Brillo actual: $(/etc/nixos/scripts/brightness-control.sh get)"
echo "   Bajando brillo..."
/etc/nixos/scripts/brightness-control.sh down
sleep 1
echo "   Subiendo brillo..."
/etc/nixos/scripts/brightness-control.sh up
echo "   Brillo final: $(/etc/nixos/scripts/brightness-control.sh get)"

echo ""
echo "=== Instrucciones ==="
echo "1. Si estás en una sesión gráfica, abre una terminal y ejecuta:"
echo "   swaymsg reload"
echo ""
echo "2. Prueba las teclas Fn+F5 y Fn+F6"
echo ""
echo "3. Si no funciona, prueba manualmente:"
echo "   /etc/nixos/scripts/brightness-control.sh up"
echo "   /etc/nixos/scripts/brightness-control.sh down"
