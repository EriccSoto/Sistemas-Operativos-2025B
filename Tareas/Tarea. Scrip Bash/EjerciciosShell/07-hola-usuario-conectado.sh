#!/bin/bash

# Función de ayuda
function ayuda() {
cat << EOF
SYNOPSIS
  $0 USUARIO_1 [USUARIO_2] ... [USUARIO_N]

DESCRIPCIÓN
  Muestra "Hola USUARIO_1, USUARIO_2, ... USUARIO_N!" por pantalla,
  solo si todos los usuarios están conectados al sistema.

CÓDIGOS DE RETORNO
  1 Si no se ingresan parámetros
  2 Si algún usuario no está conectado
EOF
}

# Validar que se haya ingresado al menos un parámetro
if [ $# -eq 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  ayuda
  exit 1
fi

# Verificar que todos los usuarios estén conectados
for USUARIO in "$@"; do
  ESTA_CONECTADO=$(who | awk '{print $1}' | grep -x "$USUARIO")
  if [ -z "$ESTA_CONECTADO" ]; then
    echo "El usuario $USUARIO no está conectado."
    ayuda
    exit 2
  fi
done

# Construir el mensaje de saludo
MENSAJE="Hola"
PRIMERO=1
for USUARIO in "$@"; do
  if [ $PRIMERO -eq 1 ]; then
    MENSAJE="$MENSAJE $USUARIO"
    PRIMERO=0
  else
    MENSAJE="$MENSAJE, $USUARIO"
  fi
done

echo "$MENSAJE!"
exit 0

