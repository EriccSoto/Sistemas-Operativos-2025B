#!/bin/bash
# Script que añade, busca y opera con movimientos bancarios mediante flags

BANCO_SCRIPT=./banco

function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPSIS
  $0 [OPCIÓN] [PARÁMETROS]

DESCRIPCIÓN
  Añade, busca, lista y opera con movimientos bancarios.

OPCIONES
  -h --help                           Muestra esta ayuda.
  -a "FECHA CONCEPTO CANTIDAD"       Añade un movimiento bancario.
  -s "PATRÓN"                         Busca un movimiento bancario.
  -l                                  Lista los movimientos ordenados por fecha.
  -t                                  Calcula el saldo total de la cuenta.

CÓDIGOS DE RETORNO
  0 Sin errores.
  1 Opción inválida.
  2 Cantidad no numérica.
  3 Número de parámetros incorrecto.
  4 Fecha inválida.
  5 Error de entrada/salida.
 12 Movimiento duplicado por fecha.
DESCRIPCION_AYUDA
}

function add() {
  echo "AÑADIR UN MOVIMIENTO BANCARIO"
  $BANCO_SCRIPT --add $@
  echo "----------------------------------"
}

function search() {
  echo "BUSCAR MOVIMIENTO BANCARIO ($1)"
  $BANCO_SCRIPT --search "$1"
  echo "----------------------------------"
}

function list() {
  echo "LISTAR ORDENADO POR FECHA"
  $BANCO_SCRIPT --list
  echo "----------------------------------"
}

function total() {
  echo "SALDO TOTAL DE LA CUENTA"
  $BANCO_SCRIPT --total
  echo "----------------------------------"
}

function opcion_invalida() {
  echo "Opción '$1' inválida."
  exit 6
}

# Procesamiento de flags
while getopts "ha:s:lt" option; do
  case "$option" in
    h) ayuda ;;
    a) add $OPTARG ;;     # Se espera: "2025-11-08 Gasolina -500"
    s) search "$OPTARG" ;;
    l) list ;;
    t) total ;;
    *) opcion_invalida "$option" ;;
  esac
done
