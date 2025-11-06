#!/bin/bash

#############################################
# INICIO VARIABLES
#############################################

FECHA=$(date +%Y.%m.%d-%H.%M.%S)
RUTA_FICHEROS=./copia_seguridad
FICHERO_ULTIMA_COPIA_TOTAL="$RUTA_FICHEROS/fecha-ultima-copia-total.txt"
FICHERO_ULTIMA_COPIA_INCREMENTAL="$RUTA_FICHEROS/fecha-ultima-copia-incremental.txt"
FICHERO_COMPRIMIDO="$RUTA_FICHEROS/incremental$FECHA.tar.zip"
DIRECTORIO_A_COPIAR=./directorio_a_copiar

#############################################
# VALIDACIONES
#############################################

# Validar existencia del directorio a copiar
if [ ! -d "$DIRECTORIO_A_COPIAR" ]; then
  echo "No existe el directorio a copiar: $DIRECTORIO_A_COPIAR"
  exit 1
fi

# Crear carpeta de destino si no existe
if [ ! -d "$RUTA_FICHEROS" ]; then
  mkdir -p "$RUTA_FICHEROS" || {
    echo "Error al crear el directorio de destino: $RUTA_FICHEROS"
    exit 2
  }
fi

# Validar existencia de la última copia total
if [ ! -f "$FICHERO_ULTIMA_COPIA_TOTAL" ]; then
  echo "No hay última copia total registrada."
  exit 1
fi

#############################################
# OPERACIONES
#############################################

# Determinar punto de referencia
if [ -f "$FICHERO_ULTIMA_COPIA_INCREMENTAL" ]; then
  REFERENCIA="$FICHERO_ULTIMA_COPIA_INCREMENTAL"
else
  REFERENCIA="$FICHERO_ULTIMA_COPIA_TOTAL"
fi

# Buscar archivos modificados
ARCHIVOS_MODIFICADOS=$(find "$DIRECTORIO_A_COPIAR" -type f -newer "$REFERENCIA")

if [ -z "$ARCHIVOS_MODIFICADOS" ]; then
  echo "No hay archivos modificados desde la última copia."
  exit 0
fi

# Registrar nueva fecha de copia incremental
echo "$FECHA" > "$FICHERO_ULTIMA_COPIA_INCREMENTAL"

# Comprimir archivos modificados
echo "$ARCHIVOS_MODIFICADOS" | zip -@ "$FICHERO_COMPRIMIDO" > /dev/null

echo "Copia incremental realizada correctamente: $FICHERO_COMPRIMIDO"
