#!/bin/bash
echo "Leyendo el archivo utilizando el comando cat"
content=$(cat to-do.txt)
echo $content

echo "Leyendo el archivo utilizando el comando leer y bucle"
filename="to-do.txt"
while read line
do
echo $line
done < $filename
