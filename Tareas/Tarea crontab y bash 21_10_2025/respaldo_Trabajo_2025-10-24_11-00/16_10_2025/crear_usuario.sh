#!/bin/bash

echo "=== Registro de nuevo usuario ==="

# Solicitar datos básicos
read -p "Nombre(s): " nombre
read -p "Apellido(s): " apellido
read -p "Dirección: " direccion
read -p "Teléfono: " telefono
read -p "Móvil: " movil
read -p "Área de trabajo: " area
read -p "Fecha de creación (DD/MM/YYYY): " fecha_creacion
# Solicitar ID único
read -p "¿Desea proporcionar un ID único? (s/n): " respuesta

if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
    read -p "Ingrese su ID único: " id_unico
else
    # Generar uno propio si no lo proporciona
    if command -v uuidgen >/dev/null 2>&1; then
        id_unico=$(uuidgen)
    else
        id_unico="ID-$(date +%s)"
    fi
fi

# Crear archivo con todos los datos
archivo="IDUNICO.TXT"
echo -e "Nombre(s): $nombre\nApellido(s): $apellido\nDirección: $direccion\nTeléfono: $telefono\nMóvil: $movil\nÁrea de trabajo: $area\nFecha de creación: $fecha_creacion\nID único: $id_unico" > "$archivo"

echo -e "\n Archivo '$archivo' creado con éxito."
