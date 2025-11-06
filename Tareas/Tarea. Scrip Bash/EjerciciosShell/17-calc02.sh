#!/bin/bash

# Función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 NUMERO_1 OPERACION NUMERO_2

DESCRIPCIÓN
  Retorna el resultado de la OPERACION entre NUMERO_1 y NUMERO_2

OPERACION puede tener estos valores:
  + sum mas
  - res menos
  x mul por
  / div entre

CÓDIGOS DE RETORNO
  1 Si el número de parámetros es distinto de 3
  2 Si algún parámetro no es un número válido
  3 Si la operación introducida es inválida
  4 Si el segundo parámetro es cero en división
DESCRIPCION_AYUDA
}

# Validación de número
function comprobarQueEsNumero() {
  echo "$1" | grep -E '^[-+]?[0-9]+([.][0-9]+)?$' > /dev/null
  if [ $? -ne 0 ]; then
    echo "El parámetro '$1' no es un número válido"
    ayuda
    exit 2
  fi
}

# Validar número de parámetros
if [ $# -ne 3 ]; then
  echo "El número de parámetros debe ser igual a 3"
  ayuda
  exit 1
fi

# Validar que el primer y tercer parámetro sean números
comprobarQueEsNumero "$1"
comprobarQueEsNumero "$3"

# Validar división por cero
if [[ "$2" =~ ^(/|div|entre)$ ]] && awk "BEGIN {exit ($3 == 0 ? 0 : 1)}"; then
  echo "No se puede dividir entre cero"
  ayuda
  exit 4
fi

# Ejecutar operación directamente con awk
case "$2" in
  +|sum|mas)     echo "$1 $3" | awk '{ print $1 + $2 }' ;;
  -|res|menos)   echo "$1 $3" | awk '{ print $1 - $2 }' ;;
  x|mul|por)     echo "$1 $3" | awk '{ print $1 * $2 }' ;;
  /|div|entre)   echo "$1 $3" | awk '{ print $1 / $2 }' ;;
  *) echo "La operación '$2' es inválida." ; ayuda ; exit 3 ;;
esac
