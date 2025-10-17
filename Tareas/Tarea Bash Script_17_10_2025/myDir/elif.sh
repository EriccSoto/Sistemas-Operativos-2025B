#!/bin/bash
echo "Ingresa un número válido"
read n
if [ $n -eq 101 ]; then
  echo "Éste es el primer número"
elif [ $n -eq 510 ]; then
  echo "Éste es el segundo número"
elif [ $n -eq 999 ]; then
  echo "Éste es el tercer número"
else
  echo "No hay números"
fi
