#!/bin/bash

CITAS_SCRIPT=./38citas.sh

#############################################
# FUNCIÓN: Mostrar ayuda
#############################################
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
$0 [OPCIONES] [ARGUMENTOS]

DESCRIPCIÓN
Interfaz CLI para gestionar citas médicas.

OPCIONES DISPONIBLES
  -h, --help     Muestra esta ayuda.
  -a, --add      Añade una cita: HORA_INICIAL HORA_FINAL NOMBRE_PACIENTE
  -s, --search   Busca pacientes que contengan PATRÓN
  -i, --init     Busca citas que comiencen a HORA_INICIAL
  -e, --end      Busca citas que terminen a HORA_FINAL
  -n, --name     Lista citas ordenadas por nombre
  -o, --hour     Lista citas ordenadas por hora inicial

CÓDIGOS DE RETORNO
 0 OK
 1 Número de parámetros incorrecto
 2 Formato incorrecto
 3 Cita solapada
 4 Nombre duplicado
 5 Opción inválida
 6 Error no especificado
DESCRIPCION_AYUDA
}

#############################################
# FUNCIÓN: Error genérico
#############################################
function error() {
    echo "$0: línea $1: $2"
    exit 5
}

#############################################
# DESPACHADOR DE OPCIONES
#############################################
case "$1" in
    -h|--help)
        ayuda
        ;;
    -a|--add)
        shift
        $CITAS_SCRIPT --add "$@"
        ;;
    -s|--search)
        shift
        $CITAS_SCRIPT --search "$@"
        ;;
    -i|--init)
        shift
        $CITAS_SCRIPT --init "$@"
        ;;
    -e|--end)
        shift
        $CITAS_SCRIPT --end "$@"
        ;;
    -n|--name)
        $CITAS_SCRIPT --name
        ;;
    -o|--hour)
        $CITAS_SCRIPT --hour
        ;;
    *)
        error $LINENO "Opción '$1' inválida."
        ;;
esac

exit 0
