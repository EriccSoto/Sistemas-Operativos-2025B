#!/bin/bash

#############################################
# VALIDACIÓN DE PARÁMETROS
#############################################

if [ "$#" -eq 0 ]; then
    cal
    exit 0
fi

if [ "$#" -ne 1 ]; then
    echo "Sólo se admite un parámetro."
    exit 1
fi

#############################################
# FORMATO DE FECHA SEGÚN PARÁMETRO
#############################################

case "$1" in
    -c|--corta)
        date +"%d/%m/%Y"
        ;;
    -l|--larga)
        date +"Hoy es el día '%d' del mes '%m' del año '%Y'."
        ;;
    *)
        echo "Opción incorrecta."
        exit 2
        ;;
esac

exit 0
