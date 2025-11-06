#!/bin/bash

# Mostrar cuántos parámetros se han recibido
echo "Número de parámetros = $#"

# Validar que se haya ingresado al menos uno
if [ $# -le 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  exit 1
fi

# Mostrar saludo con los parámetros
echo "Hola $@!"
