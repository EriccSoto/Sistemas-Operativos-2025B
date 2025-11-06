#!/bin/bash

function ayuda() {
cat << EOF
SYNOPSIS
  $0 USUARIO_1 [USUARIO_2] ... [USUARIO_N] -- MENSAJE

DESCRIPCIÓN
  Muestra "Hola USUARIO_1, USUARIO_2, ..., USUARIO_N! MENSAJE" por pantalla,
  solo si todos los usuarios están conectados al sistema.

CÓDIGOS DE RETORNO
  1 Si no se ingresan parámetros o falta el separador --
  2 Si algún usuario no está conectado
EOF
}

# Validar parámetros
if [ $# -eq 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  ayuda
  exit 1
fi

# Verificar que exista el separador --
TIENE_SEP=0
for ARG in "$@"; do
  [ "$ARG" = "--" ] && TIENE_SEP=1 && break
done
if [ $TIENE_SEP -eq 0 ]; then
  echo "Falta el separador '--' entre usuarios y mensaje."
  ayuda
  exit 1
fi

# Separar usuarios y mensaje
USUARIOS=()
MENSAJE=""
SEPARADOR_ENCONTRADO=0

for ARG in "$@"; do
  if [ "$ARG" = "--" ]; then
    SEPARADOR_ENCONTRADO=1
    continue
  fi
  if [ $SEPARADOR_ENCONTRADO -eq 0 ]; then
    USUARIOS+=("$ARG")
  else
    MENSAJE="$MENSAJE $ARG"
  fi
done

# Validar que haya al menos un usuario
if [ ${#USUARIOS[@]} -eq 0 ]; then
  echo "Debe ingresar al menos un usuario antes del separador '--'."
  ayuda
  exit 1
fi

# Verificar usuarios conectados
for USUARIO in "${USUARIOS[@]}"; do
  ESTA_CONECTADO=$(who | awk '{print $1}' | grep -x "$USUARIO")
  if [ -z "$ESTA_CONECTADO" ]; then
    echo "El usuario $USUARIO no está conectado."
    ayuda
    exit 2
  fi
done

# Construir saludo
SALUDO="Hola"
PRIMERO=1
for USUARIO in "${USUARIOS[@]}"; do
  if [ $PRIMERO -eq 1 ]; then
    SALUDO="$SALUDO $USUARIO"
    PRIMERO=0
  else
    SALUDO="$SALUDO, $USUARIO"
  fi
done

echo "$SALUDO!$MENSAJE"
exit 0
