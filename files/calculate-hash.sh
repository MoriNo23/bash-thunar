#!/bin/bash
# Calculate file hash (MD5, SHA256)
# Thunar command: bash /path/to/calculate-hash.sh %f

if [ $# -eq 0 ]; then
    echo "Usage: calculate-hash.sh <file>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "Not a file: $FILE"
    exit 1
fi

FILENAME=$(basename "$FILE")
SIZE=$(stat -c%s "$FILE" 2>/dev/null || stat -f%z "$FILE" 2>/dev/null)

echo "=== Hash Report ==="
echo "File: $FILENAME"
echo "Size: $(numfmt --to=iec "$SIZE" 2>/dev/null || echo "${SIZE} bytes")"
echo ""

if command -v md5sum &> /dev/null; then
    echo "MD5:    $(md5sum "$FILE" | cut -d' ' -f1)"
elif command -v md5 &> /dev/null; then
    echo "MD5:    $(md5 -q "$FILE")"
fi

if command -v sha256sum &> /dev/null; then
    echo "SHA256: $(sha256sum "$FILE" | cut -d' ' -f1)"
elif command -v shasum &> /dev/null; then
    echo "SHA256: $(shasum -a 256 "$FILE" | cut -d' ' -f1)"
fi

if command -v sha512sum &> /dev/null; then
    echo "SHA512: $(sha512sum "$FILE" | cut -d' ' -f1)"
fi
