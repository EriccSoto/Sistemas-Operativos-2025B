#!/bin/bash

# Función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 NOMBRE_USUARIO

DESCRIPCIÓN
  Devuelve:
    SI si NOMBRE_USUARIO coincide con algún usuario del sistema
    NO si NOMBRE_USUARIO no coincide con ningún usuario del sistema

CÓDIGOS DE RETORNO
  1 Si el número de parámetros es distinto de 1
DESCRIPCION_AYUDA
}

# Validar número de parámetros
if [ $# -ne 1 ]; then
  echo "El número de parámetros debe ser igual a 1"
  ayuda
  exit 1
fi

# Verificar si el usuario existe en /etc/passwd
ESTA_EN_SISTEMA=$(grep -E "^$1:" /etc/passwd)

if [ -z "$ESTA_EN_SISTEMA" ]; then
  echo "NO"
else
  echo "SI"
fi
