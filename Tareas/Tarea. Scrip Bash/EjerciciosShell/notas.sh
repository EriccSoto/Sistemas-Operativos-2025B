#!/bin/bash
# Interfaz para procesar notas.csv con AWK
awk -F, -f notas.awk notas.csv

