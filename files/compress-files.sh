#!/bin/bash
# Compress selected files/folders into .tar.gz
# Thunar command: bash /path/to/compress-files.sh %F

if [ $# -eq 0 ]; then
    echo "Usage: compress-files.sh file1 [file2 ...]"
    exit 1
fi

# Determine output name
FIRST=$(basename "$1")
OUTPUT="${FIRST}.tar.gz"

# If multiple files, use directory name
if [ $# -gt 1 ]; then
    PARENT=$(dirname "$1")
    DIRNAME=$(basename "$PARENT")
    OUTPUT="${DIRNAME}_archive.tar.gz"
fi

# Avoid overwriting
COUNTER=1
FINAL_OUTPUT="$OUTPUT"
while [ -e "$FINAL_OUTPUT" ]; do
    FINAL_OUTPUT="${OUTPUT%.tar.gz}_${COUNTER}.tar.gz"
    ((COUNTER++))
done

tar -czf "$FINAL_OUTPUT" "$@"

echo "Compressed to: $FINAL_OUTPUT"
