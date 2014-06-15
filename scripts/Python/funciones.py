#funciones.py
print "declarar una funcion"
def funcion1():
	print "Declaramos nuestra primera funcion1"
funcion1
print "----------------------------------------"
print "declarar y retornar una funcion"
def funcion2():
	print "Declaramos nuestra funcion2"
	return "ojala"
print funcion2()
print "----------------------------------------"
print "Retornamos la direccion de memoria de la funcion3"
def funcion3():
	print "posicion de memoria en: "
print funcion3 
print "----------------------------------------"
print "Defimos funciones con parametros y lo mostramos en pantalla"
def funcion4(x1,x2):
	print x1, " ", x2
funcion4(123,321)
print "----------------------------------------"
print "returno valor de las funciones"
def funcion5(x):
	return x*x*x
print funcion5(3)
print "----------------------------------------"
def imprimir(cadena,veces=1):
	print cadena*veces
imprimir("ojala","3")
print "----------------------------------------"
def potencia(numero,veces=1):
		valor=1
		for i range(veces):
			valor=valor*numero
		return valor
print potencia(2,16)
print potencia(veces=10,numero=2)
print "----------------------------------------"
def multiplesParam(*param):
	resultado=0
	for i in param:
		resultado=resultado+i
	return resultado 

print multiplesParam(1,2,3,4,5,6)