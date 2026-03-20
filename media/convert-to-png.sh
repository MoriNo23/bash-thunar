#!/bin/bash
# Convert image to PNG
# Thunar command: bash /path/to/convert-to-png.sh %f

if [ $# -eq 0 ]; then
    echo "Usage: convert-to-png.sh <image>"
    exit 1
fi

FILE="$1"
FILENAME=$(basename "$FILE")
NAME="${FILENAME%.*}"
DIR=$(dirname "$FILE")
OUTPUT="$DIR/${NAME}.png"

if [ "$FILE" = "$OUTPUT" ]; then
    echo "File is already PNG"
    exit 0
fi

if command -v convert &> /dev/null; then
    convert "$FILE" "$OUTPUT"
    echo "Converted: $FILENAME -> ${NAME}.png"
elif command -v ffmpeg &> /dev/null; then
    ffmpeg -i "$FILE" "$OUTPUT" -y 2>/dev/null
    echo "Converted: $FILENAME -> ${NAME}.png"
else
    echo "No converter found. Install ImageMagick or ffmpeg."
    exit 1
fi
