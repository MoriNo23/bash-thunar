#!/bin/bash
# Batch rename files with prefix/suffix
# Thunar command: bash /path/to/rename-batch.sh %F

if [ $# -eq 0 ]; then
    echo "Usage: rename-batch.sh file1 [file2 ...]"
    exit 1
fi

echo "Batch Rename"
echo "============"
echo "1) Add prefix"
echo "2) Add suffix (before extension)"
echo "3) Replace text"
echo ""
read -rp "Choose option [1-3]: " OPTION

case "$OPTION" in
    1)
        read -rp "Enter prefix: " PREFIX
        for FILE in "$@"; do
            DIR=$(dirname "$FILE")
            BASENAME=$(basename "$FILE")
            mv "$FILE" "$DIR/${PREFIX}${BASENAME}"
            echo "Renamed: $BASENAME -> ${PREFIX}${BASENAME}"
        done
        ;;
    2)
        read -rp "Enter suffix: " SUFFIX
        for FILE in "$@"; do
            DIR=$(dirname "$FILE")
            BASENAME=$(basename "$FILE")
            NAME="${BASENAME%.*}"
            EXT="${BASENAME##*.}"
            if [ "$NAME" = "$EXT" ]; then
                mv "$FILE" "$DIR/${NAME}${SUFFIX}"
            else
                mv "$FILE" "$DIR/${NAME}${SUFFIX}.${EXT}"
            fi
            echo "Renamed: $BASENAME -> ${NAME}${SUFFIX}.${EXT}"
        done
        ;;
    3)
        read -rp "Search for: " SEARCH
        read -rp "Replace with: " REPLACE
        for FILE in "$@"; do
            DIR=$(dirname "$FILE")
            BASENAME=$(basename "$FILE")
            NEWNAME="${BASENAME//$SEARCH/$REPLACE}"
            if [ "$BASENAME" != "$NEWNAME" ]; then
                mv "$FILE" "$DIR/$NEWNAME"
                echo "Renamed: $BASENAME -> $NEWNAME"
            fi
        done
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

echo ""
echo "Done!"
