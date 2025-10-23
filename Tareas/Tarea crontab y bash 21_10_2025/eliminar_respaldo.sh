#!/bin/bash

DESTINO="/home/ericc/repoSO25B/Tareas/Tarea crontab y bash 21_10_2025"
LOG="$DESTINO/log_eliminacion.txt"

# Buscar carpetas de respaldo (que empiecen con respaldo_)
RESPALDOS=$(ls -1dt "$DESTINO"/respaldo_* 2>/dev/null)

# Tomar la más antigua
CARPETA_A_ELIMINAR=$(echo "$RESPALDOS" | tail -n 1)

if [ -n "$CARPETA_A_ELIMINAR" ] && [ -d "$CARPETA_A_ELIMINAR" ]; then
    rm -rf "$CARPETA_A_ELIMINAR"
    echo "$(date): Eliminado respaldo $CARPETA_A_ELIMINAR" >> "$LOG"
else
    echo "$(date): No hay respaldos para eliminar" >> "$LOG"
fi
