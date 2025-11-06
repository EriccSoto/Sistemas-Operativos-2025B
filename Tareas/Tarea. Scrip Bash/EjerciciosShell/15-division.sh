#!/bin/bash

# Función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 NUMERO_1 NUMERO_2

DESCRIPCIÓN
  Retorna la división de NUMERO_1 entre NUMERO_2

CÓDIGOS DE RETORNO
  1 Si el número de parámetros es distinto de 2
  2 Si algún parámetro no es un número válido
  3 Si el segundo parámetro es cero
DESCRIPCION_AYUDA
}

# Función para validar si un parámetro es numérico (entero o decimal)
function comprobarQueEsNumero() {
  echo "$1" | grep -E '^[-+]?[0-9]+([.][0-9]+)?$' > /dev/null
  if [ $? -ne 0 ]; then
    echo "El parámetro '$1' no es un número válido"
    ayuda
    exit 2
  fi
}

# Validar número de parámetros
if [ $# -ne 2 ]; then
  echo "El número de parámetros debe ser igual a 2"
  ayuda
  exit 1
fi

# Validar que ambos parámetros sean números
comprobarQueEsNumero "$1"
comprobarQueEsNumero "$2"

# Validar que el divisor no sea cero (if entra cuando es cero)
DIVISOR="$2"
if echo "$DIVISOR" | awk '{ exit ($1 == 0 ? 0 : 1) }'; then
  echo "No se puede dividir entre cero"
  ayuda
  exit 3
fi

# Realizar la división con awk (soporta decimales)
echo "$1 $2" | awk '{ print $1 / $2 }'
