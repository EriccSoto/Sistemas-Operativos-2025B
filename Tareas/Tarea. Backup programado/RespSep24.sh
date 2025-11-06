#!/bin/bash

# Espera de 10 segundos para simular cron con segundos
sleep 10

# Definir rutas
ORIGEN="/home/ericc/repoSO25B/Tareas/Tarea. Backup programado/carpeta_origen"
DESTINO="/home/ericc/repoSO25B/Tareas/Tarea. Backup programado/backupNov25"

# Fecha y hora actual
FECHA=$(date +"%d%m%y_%H%M%S")

# Nombre del archivo
NOMBRE="backup${FECHA}.tar.gz"

# Crear respaldo
tar -czf "$DESTINO/$NOMBRE" "$ORIGEN"
