#!/bin/bash

#############################################
# DECLARACIÓN E INICIALIZACIÓN DEL ARRAY
#############################################

declare -a ARRAY
ARRAY=("cero" "uno" [3]="tres")
ARRAY[2]="dos"

#############################################
# ITERACIÓN Y VISUALIZACIÓN
#############################################

LENGTH=${#ARRAY[*]}

for (( i=0; i<LENGTH; i++ )); do
    echo "$i=${ARRAY[i]}"
done

