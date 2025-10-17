#!/bin/bash
echo "Ingresa un número válido"
read n
case $n in
  101)
    echo "Éste es el primer número" ;;
  510)
    echo "Éste es el segundo número" ;;
  999)
    echo "Éste es el tercer número" ;;
  *)
    echo "No hay números" ;;
esac
