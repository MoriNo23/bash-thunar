# Thunar Custom Actions Scripts

Colección de scripts bash para acciones personalizadas en Thunar (XFCE File Manager).

## Estructura

```
bash-thunar/
├── clipboard/
│   └── copy-image.sh          # Copiar imagen del clipboard
├── files/
│   ├── open-terminal-here.sh  # Abrir terminal en directorio
│   ├── compress-files.sh      # Comprimir archivos a .tar.gz
│   ├── calculate-hash.sh      # Calcular hash MD5/SHA256
│   └── rename-batch.sh        # Renombrar archivos en lote
├── media/
│   ├── image-info.sh          # Información de imagen
│   └── convert-to-png.sh      # Convertir imagen a PNG
└── utils/
    └── file-permissions.sh    # Ver permisos detallados
```

## Instalación

```bash
git clone https://github.com/tu-usuario/bash-thunar.git ~/scripts/bash-thunar
cd ~/scripts/bash-thunar
```

## Configuración en Thunar

1. Abrir Thunar
2. Ir a **Editar → Acciones personalizadas**
3. Hacer clic en **+** para nueva acción
4. Configurar:

### Ejemplo: Abrir terminal aquí

- **Nombre:** Abrir Terminal
- **Descripción:** Abrir terminal en este directorio
- **Comando:** `bash ~/scripts/bash-thunar/files/open-terminal-here.sh %f`
- **Condiciones:** Directorios

### Ejemplo: Comprimir archivos

- **Nombre:** Comprimir
- **Descripción:** Crear archivo .tar.gz
- **Comando:** `bash ~/scripts/bash-thunar/files/compress-files.sh %F`
- **Condiciones:** Archivos, Múltiples

### Ejemplo: Calcular hash

- **Nombre:** Calcular Hash
- **Descripción:** MD5/SHA256 del archivo
- **Comando:** `bash ~/scripts/bash-thunar/files/calculate-hash.sh %f`
- **Condiciones:** Archivos

### Ejemplo: Renombrar en lote

- **Nombre:** Renombrar en Lote
- **Descripción:** Renombrar múltiples archivos
- **Comando:** `bash ~/scripts/bash-thunar/files/rename-batch.sh %F`
- **Condiciones:** Archivos, Múltiples

### Ejemplo: Info de imagen

- **Nombre:** Info Imagen
- **Descripción:** Ver información de imagen
- **Comando:** `bash ~/scripts/bash-thunar/media/image-info.sh %f`
- **Condiciones:** Imágenes

### Ejemplo: Copiar imagen del clipboard

- **Nombre:** Pegar Imagen
- **Descripción:** Copiar imagen del clipboard
- **Comando:** `bash ~/scripts/bash-thunar/clipboard/copy-image.sh %f`
- **Condiciones:** Directorios

## Variables de Thunar

| Variable | Descripción |
|----------|-------------|
| `%f` | Archivo/directorio seleccionado |
| `%F` | Múltiples archivos seleccionados |
| `%d` | Directorio del archivo |
| `%D` | Directorios de múltiples archivos |
| `%n` | Nombre del archivo |
| `%N` | Nombres de múltiples archivos |

## Dependencias

Scripts opcionales requieren herramientas específicas:

- `xclip` / `xsel` / `wl-clipboard` - Para copy-image.sh
- `tar` - Para compress-files.sh
- `md5sum` / `sha256sum` - Para calculate-hash.sh
- `ImageMagick` / `ffmpeg` - Para convert-to-png.sh
- `identify` / `exiftool` - Para image-info.sh

## Uso directo (sin Thunar)

También puedes usar los scripts directamente en terminal:

```bash
# Abrir terminal en directorio actual
bash ~/scripts/bash-thunar/files/open-terminal-here.sh .

# Comprimir archivos
bash ~/scripts/bash-thunar/files/compress-files.sh archivo1.txt archivo2.txt

# Calcular hash
bash ~/scripts/bash-thunar/files/calculate-hash.sh archivo.txt
```
