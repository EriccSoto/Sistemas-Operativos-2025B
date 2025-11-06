#!/bin/bash

# Función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 NOMBRE_1 [NOMBRE_2] ... [NOMBRE_N]

DESCRIPCIÓN
  Muestra "Hola NOMBRE_1, NOMBRE_2, ... NOMBRE_N!" por pantalla,
  solo si todos los nombres corresponden a usuarios del sistema.

CÓDIGOS DE RETORNO
  1 Si el número de parámetros es menor que 1
  2 Si algún usuario no está en el sistema
DESCRIPCION_AYUDA
}

# Validar número de parámetros
if [ $# -le 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  ayuda
  exit 1
fi

MENSAJE="Hola"
PRIMERO=1

# Iterar sobre los parámetros
while [ -n "$1" ]; do
  ESTA_USUARIO=$(./10-usuariosistema.sh "$1")

  if [ "$ESTA_USUARIO" = "NO" ]; then
    echo "El usuario $1 no está en el sistema"
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

# Mostrar saludo
echo "$MENSAJE!"
