#!/bin/bash
# Script to copy image from clipboard to repository
# Supports: xclip, xsel, copyq, wl-clipboard (Wayland)

set -e

# Get target directory (default to current directory)
TARGET_DIR="${1:-.}"
mkdir -p "$TARGET_DIR"

# Generate filename with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="screenshot_${TIMESTAMP}.png"
FILEPATH="$TARGET_DIR/$FILENAME"

echo "Trying to copy image from clipboard..."

# Try xclip (X11)
if command -v xclip &> /dev/null; then
    echo "Using xclip..."
    if xclip -selection clipboard -t image/png -o > "$FILEPATH" 2>/dev/null; then
        if [ -s "$FILEPATH" ]; then
            echo "✓ Image copied successfully with xclip"
            echo "File saved to: $FILEPATH"
            exit 0
        fi
    fi
fi

# Try xsel (X11)
if command -v xsel &> /dev/null; then
    echo "Using xsel..."
    if xsel --clipboard --output > "$FILEPATH" 2>/dev/null; then
        if [ -s "$FILEPATH" ]; then
            echo "✓ Image copied successfully with xsel"
            echo "File saved to: $FILEPATH"
            exit 0
        fi
    fi
fi

# Try copyq
if command -v copyq &> /dev/null; then
    echo "Using copyq..."
    COPYQ_DATA=$(copyq clipboard 2>/dev/null)
    if [ -n "$COPYQ_DATA" ]; then
        echo "$COPYQ_DATA" > "$FILEPATH"
        if [ -s "$FILEPATH" ]; then
            echo "✓ Image copied successfully with copyq"
            echo "File saved to: $FILEPATH"
            exit 0
        fi
    fi
fi

# Try wl-clipboard (Wayland)
if command -v wl-paste &> /dev/null; then
    echo "Using wl-paste (Wayland)..."
    if wl-paste --type image/png > "$FILEPATH" 2>/dev/null; then
        if [ -s "$FILEPATH" ]; then
            echo "✓ Image copied successfully with wl-paste"
            echo "File saved to: $FILEPATH"
            exit 0
        fi
    fi
fi

echo ""
echo "Failed to copy image from clipboard."
echo "Available clipboard tools:"
command -v xclip &> /dev/null && echo "  ✓ xclip"
command -v xsel &> /dev/null && echo "  ✓ xsel"
command -v copyq &> /dev/null && echo "  ✓ copyq"
command -v wl-paste &> /dev/null && echo "  ✓ wl-paste (Wayland)"
echo ""
echo "Manual method:"
echo "  xclip -selection clipboard -t image/png -o > $FILEPATH"
echo "  wl-paste --type image/png > $FILEPATH (Wayland)"
exit 1
