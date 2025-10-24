def cifrado_cesar(texto, clave):
    resultado = ""
    for caracter in texto:
        if caracter.isalpha():
            base = ord('A') if caracter.isupper() else ord('a')
            desplazado = (ord(caracter) - base + clave) % 26 + base
            resultado += chr(desplazado)
        else:
            resultado += caracter
    return resultado

# Solicitar entradas
nombre = input("Ingrese su nombre: ")
apellido_paterno = input("Ingrese su apellido paterno: ")
apellido_materno = input("Ingrese su apellido materno: ")

# Encriptar cada parte por separado
nombre_cesar = cifrado_cesar(nombre, 3)
apellido_paterno_cesar = cifrado_cesar(apellido_paterno, 3)
apellido_materno_cesar = cifrado_cesar(apellido_materno, 3)

# Mostrar resultados con formato solicitado
print(f"\nNombre: {nombre}")
print(f"César: {nombre_cesar}\n")

print(f"Apellido paterno: {apellido_paterno}")
print(f"César: {apellido_paterno_cesar}\n")

print(f"Apellido materno: {apellido_materno}")
print(f"César: {apellido_materno_cesar}\n")

# Impresión conjunta
print("allcesar:")
print(f"Nombre completo: {nombre} {apellido_paterno} {apellido_materno}")
print(f"Cifrado César: {nombre_cesar} {apellido_paterno_cesar} {apellido_materno_cesar}")

