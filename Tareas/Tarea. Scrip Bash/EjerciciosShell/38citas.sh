#!/bin/bash

CITAS_FILE=~/citas.txt

function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
$0 [OPCIONES] [HORA_INICIO] [HORA_FINAL] [NOMBRE_PACIENTE]

DESCRIPCIÓN
Gestión de citas médicas.

OPCIONES
 -h --help     Muestra esta ayuda.
 -a --add      Añade una cita con HORA_INICIO, HORA_FINAL y NOMBRE_PACIENTE.
 -s --search   Busca pacientes que contengan PATRÓN.
 -i --init     Busca citas que comiencen a HORA_INICIO.
 -e --end      Busca citas que terminen a HORA_FINAL.
 -n --name     Lista todas las citas ordenadas por NOMBRE_PACIENTE.
 -o --hour     Lista todas las citas ordenadas por HORA_INICIO.

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

function error() {
    echo "$0: Línea $1: Error $3: $2"
    exit $3
}

function validarHora() {
    [[ "$1" =~ ^[0-9]{1,2}$ ]] && [ "$1" -ge 0 ] && [ "$1" -le 23 ]
}

function solapada() {
    local ini=$1
    local fin=$2
    while IFS=: read -r h1 h2 nombre; do
        if [ "$ini" -lt "$h2" ] && [ "$fin" -gt "$h1" ]; then
            return 0
        fi
    done < "$CITAS_FILE"
    return 1
}

function nombreDuplicado() {
    grep -q ":.*:$1\$" "$CITAS_FILE"
}

function addCita() {
    [ "$#" -ne 3 ] && error $LINENO "Número de parámetros incorrecto" 1
    validarHora "$1" && validarHora "$2" || error $LINENO "Formato de hora incorrecto" 2
    [ "$1" -ge "$2" ] && error $LINENO "Hora inicio debe ser menor que hora fin" 2
    nombreDuplicado "$3" && error $LINENO "Nombre duplicado" 4
    solapada "$1" "$2" && error $LINENO "Cita solapada" 3
    echo "$1:$2:$3" >> "$CITAS_FILE"
    echo "Cita añadida correctamente."
}

function buscarPorPatron() {
    [ "$#" -ne 1 ] && error $LINENO "Número de parámetros incorrecto" 1
    grep "$1" "$CITAS_FILE"
}

function buscarPorInicio() {
    [ "$#" -ne 1 ] && error $LINENO "Número de parámetros incorrecto" 1
    validarHora "$1" || error $LINENO "Formato de hora incorrecto" 2
    awk -F: -v h="$1" '$1==h' "$CITAS_FILE"
}

function buscarPorFin() {
    [ "$#" -ne 1 ] && error $LINENO "Número de parámetros incorrecto" 1
    validarHora "$1" || error $LINENO "Formato de hora incorrecto" 2
    awk -F: -v h="$1" '$2==h' "$CITAS_FILE"
}

function ordenarPorNombre() {
    sort -t: -k3 "$CITAS_FILE"
}

function ordenarPorHora() {
    sort -t: -k1n "$CITAS_FILE"
}

case "$1" in
    -h|--help) ayuda ;;
    -a|--add) shift; addCita "$@" ;;
    -s|--search) shift; buscarPorPatron "$@" ;;
    -i|--init) shift; buscarPorInicio "$@" ;;
    -e|--end) shift; buscarPorFin "$@" ;;
    -n|--name) ordenarPorNombre ;;
    -o|--hour) ordenarPorHora ;;
    *) error $LINENO "Opción inválida" 5 ;;
esac

exit 0
