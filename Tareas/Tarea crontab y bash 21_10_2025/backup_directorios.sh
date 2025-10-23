#!/bin/bash

# Directorios origen
ORIGEN1="/home/ericc/repoSO25B/Examen1P"
ORIGEN2="/home/ericc/repoSO25B/Asistencias"
ORIGEN3="/home/ericc/repoSO25B/Trabajo_en_clase"

# Directorio destino (exacto, sin subcarpetas)
DESTINO="/home/ericc/repoSO25B/Tareas/Tarea crontab y bash 21_10_2025"
LOG="$DESTINO/log_backup.txt"

# Fecha actual
FECHA=$(date +"%Y-%m-%d_%H-%M")

# Respaldar cada directorio con nombre único
cp -r "$ORIGEN1" "$DESTINO/respaldo_Examen1P_$FECHA"
cp -r "$ORIGEN2" "$DESTINO/respaldo_Asistencias_$FECHA"
cp -r "$ORIGEN3" "$DESTINO/respaldo_Trabajo_$FECHA"

# Registrar en log
echo "$FECHA: Backup generado de Examen1P, Asistencias y Trabajo_en_clase" >> "$LOG"
