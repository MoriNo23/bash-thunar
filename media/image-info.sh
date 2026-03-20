#!/bin/bash
# Show image information
# Thunar command: bash /path/to/image-info.sh %f

if [ $# -eq 0 ]; then
    echo "Usage: image-info.sh <image>"
    exit 1
fi

FILE="$1"
FILENAME=$(basename "$FILE")

echo "=== Image Info ==="
echo "File: $FILENAME"
echo "Path: $FILE"
echo ""

# Try identify (ImageMagick)
if command -v identify &> /dev/null; then
    identify -verbose "$FILE" 2>/dev/null | head -20
    echo ""
    echo "Dimensions: $(identify -format '%wx%h' "$FILE" 2>/dev/null)"
    echo "Format: $(identify -format '%m' "$FILE" 2>/dev/null)"
    echo "Colorspace: $(identify -format %[colorspace] "$FILE" 2>/dev/null)"
    echo "Depth: $(identify -format %[depth] "$FILE" 2>/dev/null) bits"
# Try file command
elif command -v file &> /dev/null; then
    file "$FILE"
fi

# Try exiftool
if command -v exiftool &> /dev/null; then
    echo ""
    echo "=== EXIF Data ==="
    exiftool "$FILE" 2>/dev/null | head -15
fi
