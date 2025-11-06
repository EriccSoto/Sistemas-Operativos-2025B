#!/bin/bash

#############################################
# INICIO VARIABLES
#############################################

ROLES_FILE=./roles.csv

#############################################
# EXTRAER ROLES ÚNICOS
#############################################

ROLES=$(cut -d : -f 2 "$ROLES_FILE" | tr ',' '\n' | sort | uniq)

#############################################
# AGRUPAR USUARIOS POR ROL
#############################################

for ROL in $ROLES; do
    echo "$ROL"
    NAMES=$(grep "$ROL" "$ROLES_FILE" | cut -d : -f 1 | tr '\n' ' ')
    echo " -> $NAMES"
done
