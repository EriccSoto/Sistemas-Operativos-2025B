#!/bin/bash
echo "Ingresa un número"
read num
if [[ $num -gt 10 ]]
then
echo "El número es mayor a 10"
else
echo "El número es menor a 10"
fi
