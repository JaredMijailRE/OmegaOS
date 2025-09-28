#!/bin/bash
# Script de diagnóstico para River
# Ejecutar en el sistema NixOS por SSH

echo "=== DIAGNÓSTICO DE RIVER ==="
echo "Fecha: $(date)"
echo

echo "1. Verificando archivo init de River:"
if [ -f ~/.config/river/init ]; then
    echo "✅ Archivo existe: ~/.config/river/init"
    ls -la ~/.config/river/init
    echo "Contenido del archivo:"
    cat ~/.config/river/init
else
    echo "❌ Archivo NO existe: ~/.config/river/init"
fi
echo

echo "2. Verificando directorio river:"
if [ -d ~/.config/river ]; then
    echo "✅ Directorio existe: ~/.config/river"
    ls -la ~/.config/river/
else
    echo "❌ Directorio NO existe: ~/.config/river"
fi
echo

echo "3. Verificando procesos de River:"
ps aux | grep river | grep -v grep
echo

echo "4. Verificando archivo de debug:"
if [ -f /tmp/river-debug.log ]; then
    echo "✅ Archivo de debug existe:"
    cat /tmp/river-debug.log
else
    echo "❌ Archivo de debug NO existe"
fi
echo

echo "5. Verificando logs del sistema (últimos 10 minutos):"
journalctl --since "10 minutes ago" | grep -i river
echo

echo "6. Verificando si riverctl funciona:"
which riverctl
riverctl --version 2>/dev/null || echo "riverctl no responde"
echo

echo "=== FIN DEL DIAGNÓSTICO ==="
