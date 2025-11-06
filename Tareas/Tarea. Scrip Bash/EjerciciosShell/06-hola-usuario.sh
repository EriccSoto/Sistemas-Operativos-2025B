#!/bin/bash

# Función de ayuda
function ayuda() {
cat << EOF
SYNOPSIS
  $0 NOMBRE_1 [NOMBRE_2] ... [NOMBRE_N]

DESCRIPCIÓN
  Muestra "Hola NOMBRE_1, NOMBRE_2, ... NOMBRE_N!" por pantalla,
  solo si los usuarios están conectados al sistema.

CÓDIGOS DE RETORNO
  1 Si el número de parámetros es menor que 1
  2 Si algún usuario no está conectado
EOF
}

# Validar que se haya ingresado al menos un parámetro
if [ $# -le 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  ayuda
  exit 1
fi

MENSAJE="Hola"
PRIMERO=1

# Iterar sobre los parámetros
while [ -n "$1" ]; do
  ESTA_CONECTADO=$(who | awk '{print $1}' | grep -x "$1")
  if [ -z "$ESTA_CONECTADO" ]; then
    echo "El usuario $1 no está conectado."
    ayuda
    exit 2
  fi

  if [ $PRIMERO -eq 1 ]; then
    MENSAJE="$MENSAJE $1"
    PRIMERO=0
  else
    MENSAJE="$MENSAJE, $1"
  fi
  shift
done

# Mostrar el saludo final
echo "$MENSAJE!"
