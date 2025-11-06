#!/bin/bash

#############################################
# FUNCIÓN: Verificar número de parámetros
#############################################
function verificarNumeroParametros() {
    if [ "$#" -eq 0 ]; then
        echo "Hay que introducir al menos un parámetro."
        exit 1
    fi
}

#############################################
# FUNCIÓN: Crear jaula si no existe
#############################################
function crearJaula() {
    JAULA="$HOME/.jaula"
    if [ -e "$JAULA" ]; then
        if [ ! -d "$JAULA" ]; then
            echo "El fichero '$JAULA' no es un directorio."
            exit 3
        fi
    else
        mkdir "$JAULA"
    fi
}

#############################################
# FUNCIÓN: Mover ficheros a la jaula
#############################################
function moverFicheros() {
    for FICHERO in "$@"; do
        if [ ! -e "$FICHERO" ]; then
            echo "El fichero '$FICHERO' no existe."
            exit 2
        fi
        mv "$FICHERO" "$JAULA"
    done
}

#############################################
# EJECUCIÓN
#############################################
verificarNumeroParametros "$@"
crearJaula
moverFicheros "$@"
