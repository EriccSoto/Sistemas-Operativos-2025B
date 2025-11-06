#!/bin/bash

#############################################
# VALIDACIÓN DE PARÁMETROS
#############################################

if [ $# -ne 2 ]; then
    echo "Para ejecutar este script se necesitan 2 números."
    exit 2
fi

#############################################
# CÁLCULO DE POTENCIA
#############################################

BASE=$1
EXPONENTE=$2
ELEVADO=1

for (( CONTADOR=0; CONTADOR<EXPONENTE; CONTADOR++ )); do
    ELEVADO=$(echo "$ELEVADO * $BASE" | bc)
done

echo "$BASE elevado a $EXPONENTE es: $ELEVADO"

