#!/bin/bash

#############################################
# VALIDACIÓN DE PARÁMETROS
#############################################

if [ "$#" != "0" ]; then
    echo "No se permiten parámetros."
    exit 1
fi

#############################################
# LISTADO ORDENADO POR TAMAÑO
#############################################

ls -l | sort -nk 5 | awk '{ print $9 }' | nl

