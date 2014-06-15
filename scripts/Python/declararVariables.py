print "define una variable e imprime la misma"
var=0
print var
print "---------------------------------------------"
print "define una varibale entera con cadena con str"
var="Hola..."
print var + str(123)
print "---------------------------------------------"
print "define una variables local"
var="hola"
print var 
def funcion():
	print "amigo"
funcion()
var="adios"
print var 
print "---------------------------------------------"
print "define una variable local y global"
var=estableciendo 
print var
def globalmain():
	global var
	var="Repite"
	print var
globalmain()
var="estableciendo ###"
print var 
print "---------------------------------------------"
print "Elimina una variable definida"
var="delete"
print var
del var

