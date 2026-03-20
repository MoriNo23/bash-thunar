#!/bin/bash
# Open terminal in selected directory or parent of selected file
# Thunar command: bash /path/to/open-terminal-here.sh %f

TARGET="${1:-.}"

if [ -f "$TARGET" ]; then
    TARGET=$(dirname "$TARGET")
fi

cd "$TARGET" || exit 1

# Try common terminal emulators
for term in xterm xfce4-terminal alacritty kitty gnome-terminal konsole; do
    if command -v "$term" &> /dev/null; then
        case "$term" in
            xfce4-terminal)
                xfce4-terminal --working-directory="$TARGET" &
                ;;
            alacritty)
                alacritty --working-directory "$TARGET" &
                ;;
            kitty)
                kitty --directory "$TARGET" &
                ;;
            gnome-terminal)
                gnome-terminal --working-directory="$TARGET" &
                ;;
            konsole)
                konsole --workdir "$TARGET" &
                ;;
            xterm)
                xterm -e "cd '$TARGET' && $SHELL" &
                ;;
        esac
        exit 0
    fi
done

echo "No terminal emulator found"
exit 1
