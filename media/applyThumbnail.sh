#!/bin/bash
# Aplicar miniatura a carpeta usando cover-thumbnailer
# Thunar: bash /path/to/aplicarMiniatura.sh %f
# Uso: bash aplicarMiniatura.sh [directorio]

TARGET="${1:-.}"

# Si es archivo, usar su directorio padre
if [ -f "$TARGET" ]; then
    TARGET=$(dirname "$TARGET")
fi

TARGET=$(realpath "$TARGET")

# Verificar dependencia
if ! command -v cover-thumbnailer &> /dev/null; then
    echo "Error: cover-thumbnailer no está instalado"
    echo "Instalar: sudo apt install cover-thumbnailer"
    exit 1
fi

# Generar miniatura
THUMB_DIR="${HOME}/.cache/thumbnails/normal"
mkdir -p "$THUMB_DIR"

DIR_NAME=$(basename "$TARGET")
THUMB_FILE="${THUMB_DIR}/${DIR_NAME}.png"

echo "Directorio: $TARGET"
echo "Generando miniatura..."

if cover-thumbnailer "$TARGET" "$THUMB_FILE"; then
    echo "✓ Miniatura aplicada: $THUMB_FILE"

    # Copiar como .directory thumbnail si es posible
    if [ -f "$THUMB_FILE" ]; then
        cp "$THUMB_FILE" "$TARGET/.directory.png" 2>/dev/null
        echo "✓ Copiada a: $TARGET/.directory.png"
    fi
else
    echo "✗ Error al generar miniatura"
    exit 1
fi
