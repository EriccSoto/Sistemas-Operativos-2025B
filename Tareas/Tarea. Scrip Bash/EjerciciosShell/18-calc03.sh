#!/bin/bash

# Función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 EXPRESION_NUMERICA

DESCRIPCIÓN
  Muestra por pantalla el valor de EXPRESION_NUMERICA.

CÓDIGOS DE RETORNO
  0 Si no hay ningún error.
  1 Si el número de parámetros es distinto de 1.
  2 Si hay un error de formato en la expresión introducida.
  3 Si hay un error de entrada y salida.
  4 Si hay un error al ejecutar la expresión introducida.
DESCRIPCION_AYUDA
}

# Función de error
function error() {
  echo "$0: línea $1: Error $3: $2"
  exit $3
}

# Mostrar ayuda si se solicita
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  ayuda
  exit 0
fi

# Validar número de parámetros
if [ $# -ne 1 ]; then
  error $LINENO "Hay que introducir 1 y solamente 1 parámetro." 1
fi

# Validar expresión: dígitos, punto decimal, operadores, paréntesis y espacios
echo "$1" | grep -E '^[[:space:][:digit:]\.\+\*/\(\)\-]+$' > /dev/null
if [ $? -ne 0 ]; then
  error $LINENO "Error de formato en la expresión introducida." 2
fi

# Guardar expresión en archivo oculto
echo "{ print $1 }" > ~/.expresion.awk
if [ $? -ne 0 ]; then
  error $LINENO "Error de entrada y salida." 3
fi

# Ejecutar expresión con awk
echo "" | awk -f ~/.expresion.awk 2> ~/.log.awk
if [ $? -ne 0 ]; then
  error $LINENO "Error al ejecutar la expresión introducida." 4
fi
