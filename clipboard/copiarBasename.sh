#!/bin/bash

# Salir si no hay argumento
[ -z "$1" ] && exit 1

# Limpiar ruta y última extensión
temp="${1##*/}"
nombre="${temp%.*}"

# Copiar al portapapeles sin salida de texto (redirección a /dev/null)
if command -v wl-copy &> /dev/null; then
    echo -n "$nombre" | wl-copy
elif command -v xclip &> /dev/null; then
    echo -n "$nombre" | xclip -selection clipboard
fi
