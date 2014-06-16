##### Establecemos un condicional de tipo 
texto="cadena"
if texto == "cadena":
	print texto

##### Ingresamos valores a través del teclado para el tipo cadena, y tenemos
##### 2 condiciones if/else 
texto=raw_input("> "):
if texto == "cadena"
	print "Escribistes cadena"
else:
	print "No escribistes cadena"

###### Para varias condicionales puedes tener varios elif pero solo un else
numero=int(raw_input(">"))
if numero > 0:
	print "Es un numero positivo"
elif numero < 0 :
	print "Es un numero negativo"
else:
	print "Es un cero"