#!/bin/bash

CITAS_SCRIPT=./38citas.sh

function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
$0 [OPCIONES]

DESCRIPCIÓN
Interfaz para añadir y buscar citas médicas.

OPCIONES
 -h, --help   Muestra esta ayuda.

CÓDIGOS DE RETORNO
 0 Si no hay ningún error.
DESCRIPCION_AYUDA
}

function menu() {
cat << DESCRIPCION_MENU
+---------------------------------------------+
| MENU DE CITAS                               |
+---------------------------------------------+
| 1. Añadir cita nueva                        |
| 2. Buscar por nombre del paciente           |
| 3. Buscar citas por hora inicial            |
| 4. Buscar citas por hora final              |
| 5. Listar citas ordenadas por nombre        |
| 6. Listar citas ordenadas por hora inicial  |
| 7. Salir del programa                       |
+---------------------------------------------+
DESCRIPCION_MENU
}

function error() {
    echo "$0: línea $1: $2"
}

function add() {
    echo "AÑADIR UNA CITA NUEVA"
    read -p "Introduce la hora inicial (00–23): " HORA_INICIAL
    read -p "Introduce la hora final (00–23): " HORA_FINAL
    read -p "Introduce el nombre del paciente: " NOMBRE_PACIENTE
    $CITAS_SCRIPT --add "$HORA_INICIAL" "$HORA_FINAL" "$NOMBRE_PACIENTE"
}

function search() {
    echo "BUSCAR POR NOMBRE DEL PACIENTE"
    read -p "Introduce un patrón de búsqueda: " PATRON
    $CITAS_SCRIPT --search "$PATRON"
}

function init() {
    echo "BUSCAR POR HORA INICIAL"
    read -p "Introduce la hora inicial (00–23): " HORA_INICIAL
    $CITAS_SCRIPT --init "$HORA_INICIAL"
}

function end() {
    echo "BUSCAR POR HORA FINAL"
    read -p "Introduce la hora final (00–23): " HORA_FINAL
    $CITAS_SCRIPT --end "$HORA_FINAL"
}

function name() {
    echo "LISTADO ORDENADO POR NOMBRE DEL PACIENTE"
    $CITAS_SCRIPT --name
}

function hour() {
    echo "LISTADO ORDENADO POR HORA INICIAL"
    $CITAS_SCRIPT --hour
}

function salir() {
    echo "Saliendo del programa..."
    exit 0
}

# Bucle principal
while true; do
    menu
    read -p "Seleccione una opción (1–7): " OPCION
    case "$OPCION" in
        1) add ;;
        2) search ;;
        3) init ;;
        4) end ;;
        5) name ;;
        6) hour ;;
        7) salir ;;
        *) error $LINENO "Opción inválida. Intente de nuevo." ;;
    esac
    echo ""
    read -p "Presione ENTER para continuar..." dummy
    clear
done
