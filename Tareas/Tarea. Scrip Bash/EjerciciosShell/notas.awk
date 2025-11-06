BEGIN {
  # Encabezado
  print "+------------------------+------+-------+-------+------+-------+"
  print "| NOMBRE         EX1   EX2   EX3  | MED  | APTO |"
  print "+------------------------+------+-------+-------+------+-------+"
}
NR > 1 {
  # Acumulados por columna (saltando encabezado)
  suma1 += $2
  suma2 += $3
  suma3 += $4

  # Cálculo de media por fila y aptitud
  media = ($2 + $3 + $4) / 3
  apto = (media >= 5) ? "SI" : "NO"
  if (apto == "SI") aptos++

  # Fila formateada
  printf "| %-13s %4.1f  %4.1f  %4.1f | %4.1f |  %-3s |\n", $1, $2, $3, $4, media, apto
}
END {
  # Totales por columna y media global
  filas = NR - 1
  prom1 = suma1 / filas
  prom2 = suma2 / filas
  prom3 = suma3 / filas
  promTotal = (prom1 + prom2 + prom3) / 3

  # Pie de tabla
  print "+------------------------+------+-------+-------+------+-------+"
  printf "| TOTAL          %4.1f  %4.1f  %4.1f | %4.1f |   %d   |\n", prom1, prom2, prom3, promTotal, aptos
  print "+------------------------+------+-------+-------+------+-------+"
}
