#!/bin/bash

############################################################
# INICIO VARIABLES
############################################################

FECHA=$(date +%Y.%m.%d-%H.%M.%S)
RUTA_FICHEROS=~/copia_seguridad
FICHERO_ULTIMA_COPIA_TOTAL="$RUTA_FICHEROS/fecha-ultima-copia-total.txt"
FICHERO_ULTIMA_COPIA_DIFERENCIAL="$RUTA_FICHEROS/fecha-ultima-copia-diferencial.txt"
FICHERO_COMPRIMIDO="$RUTA_FICHEROS/diferencial$FECHA.tar.zip"
DIRECTORIO_A_COPIAR=./directorio_a_copiar

############################################################
# VALIDACIONES
############################################################

if [ ! -d "$DIRECTORIO_A_COPIAR" ]; then
  echo "No existe el directorio a copiar: $DIRECTORIO_A_COPIAR"
  exit 1
fi

if [ ! -f "$FICHERO_ULTIMA_COPIA_TOTAL" ]; then
  echo "No hay última copia total registrada."
  exit 1
fi

if [ ! -d "$RUTA_FICHEROS" ]; then
  mkdir -p "$RUTA_FICHEROS" || {
    echo "Error al crear el directorio de destino: $RUTA_FICHEROS"
    exit 2
  }
fi

############################################################
# OPERACIONES
############################################################

echo "$FECHA" > "$FICHERO_ULTIMA_COPIA_DIFERENCIAL"

ARCHIVOS_MODIFICADOS=$(find "$DIRECTORIO_A_COPIAR" -type f -newer "$FICHERO_ULTIMA_COPIA_TOTAL")

if [ -z "$ARCHIVOS_MODIFICADOS" ]; then
  echo "No hay archivos modificados desde la última copia total."
  exit 0
fi

echo "$ARCHIVOS_MODIFICADOS" | zip -@ "$FICHERO_COMPRIMIDO" > /dev/null

echo "Copia diferencial realizada correctamente: $FICHERO_COMPRIMIDO"
