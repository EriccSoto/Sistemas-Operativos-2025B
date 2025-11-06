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

# Ejecutar operación
case "$2" in
  +|sum|mas)     ./12-suma.sh       "$1" "$3" ;;
  -|res|menos)   ./13-resta.sh      "$1" "$3" ;;
  x|mul|por)     ./14-multiplica.sh "$1" "$3" ;;
  /|div|entre)   ./15-division.sh   "$1" "$3" ;;
  *) echo "La operación '$2' es inválida." ; ayuda ; exit 3 ;;
esac

