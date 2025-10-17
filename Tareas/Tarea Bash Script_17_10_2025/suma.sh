#!/bin/bash
addition () {
  sum=$(($1 + $2))
  return $sum
}
read -p "Ingresa un número: " int1
read -p "Ingresa un número: " int2
addition $int1 $int2
echo "El resultado es : " $?
