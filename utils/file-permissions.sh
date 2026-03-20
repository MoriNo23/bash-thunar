#!/bin/bash
# Show detailed file permissions
# Thunar command: bash /path/to/file-permissions.sh %f

if [ $# -eq 0 ]; then
    echo "Usage: file-permissions.sh <file>"
    exit 1
fi

FILE="$1"
FILENAME=$(basename "$FILE")

echo "=== Permissions Report ==="
echo "File: $FILENAME"
echo ""

# Show permissions in different formats
PERMS=$(stat -c '%a' "$FILE" 2>/dev/null || stat -f '%Lp' "$FILE" 2>/dev/null)
OWNER=$(stat -c '%U:%G' "$FILE" 2>/dev/null || stat -f '%Su:%Sg' "$FILE" 2>/dev/null)

echo "Octal: $PERMS"
echo "Owner: $OWNER"
echo ""

# Show symbolic permissions
ls -la "$FILE"

echo ""
echo "=== Permission Breakdown ==="
if [ -r "$FILE" ]; then echo "  Readable: Yes"; else echo "  Readable: No"; fi
if [ -w "$FILE" ]; then echo "  Writable: Yes"; else echo "  Writable: No"; fi
if [ -x "$FILE" ]; then echo "  Executable: Yes"; else echo "  Executable: No"; fi
if [ -d "$FILE" ]; then echo "  Type: Directory"; else echo "  Type: File"; fi

# SUID/SGID/Sticky bits
PERMS_NUM=$(stat -c '%a' "$FILE" 2>/dev/null)
if [ -n "$PERMS_NUM" ]; then
    if [ "${PERMS_NUM:0:1}" != "0" ]; then
        echo ""
        echo "Special bits:"
        [ $((PERMS_NUM / 100 % 10)) -ge 4 ] && echo "  SUID bit set"
        [ $((PERMS_NUM / 100 % 10)) -ge 2 ] && echo "  SGID bit set"
        [ $((PERMS_NUM / 100 % 10)) -ge 1 ] && echo "  Sticky bit set"
    fi
fi
