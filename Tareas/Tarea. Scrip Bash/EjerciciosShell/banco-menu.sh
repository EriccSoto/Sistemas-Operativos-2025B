#!/bin/bash
# Script que añade, busca y opera con movimientos bancarios

BANCO_SCRIPT=./banco

function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 [OPCIONES]

DESCRIPCIÓN
  Añade, busca y opera con movimientos bancarios.

OPCIONES
  -h --help   Muestra esta ayuda.

CÓDIGOS DE RETORNO
  0 Si no hay ningún error.
DESCRIPCION_AYUDA
}

function menu() {
cat << DESCRIPCION_MENU
+----------------------------------------------+
| MENU DEL BANCO                               |
+----------------------------------------------+
| a - Añadir un movimiento bancario            |
| b - Buscar un movimiento bancario            |
| l - Listar movimientos ordenados por fecha   |
| c - Calcular el saldo total de la cuenta     |
| s - Salir del programa                       |
+----------------------------------------------+
DESCRIPCION_MENU
}

function error() {
  echo "$0: línea $1: $2"
}

function add() {
  echo "AÑADIR UN MOVIMIENTO BANCARIO"
  read -p "Introduce la fecha (YYYY-MM-DD): " FECHA
  read -p "Introduce el concepto: " CONCEPTO
  read -p "Introduce la cantidad: " CANTIDAD
  $BANCO_SCRIPT --add "$FECHA" "$CONCEPTO" "$CANTIDAD"
  elegir_menu
}

function search() {
  echo "BUSCAR MOVIMIENTO BANCARIO"
  read -p "Introduce un patrón de búsqueda: " PATRON
  $BANCO_SCRIPT --search "$PATRON"
  elegir_menu
}

function list() {
  echo "LISTAR ORDENADO POR FECHA"
  $BANCO_SCRIPT --list
  elegir_menu
}

function total() {
  echo "SALDO TOTAL DE LA CUENTA"
  $BANCO_SCRIPT --total
  elegir_menu
}

function salir() {
  echo "Saliendo del programa..."
  exit 0
}

function opcion_invalida() {
  echo "Opción '$1' inválida."
  elegir_menu
}

function elegir_menu() {
  menu
  read -p "Elige una opción: " OPCION
  clear
  case "$OPCION" in
    a) add ;;
    b) search ;;
    l) list ;;
    c) total ;;
    s) salir ;;
    *) opcion_invalida "$OPCION" ;;
  esac
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  ayuda
  exit 0
fi

clear
elegir_menu
