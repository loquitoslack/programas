####### Crea una clase 
class miClase():
	def metodo1(self):
		print "Metodo1 de la clase miClase"
	def metodo2(self,texto):
		print "el metodo2 recibe la cadena" + texto

class claseDos(miClase):
	def metodo2(self):
		print "metodo2 de la claseDos"
	def metodo1(self):
		miclase.metodo1(self)
		print "metodo1 de la clase ClaseDos"

def main():
	objeto=miClase()
	objeto.metodo1()
	objeto.metodo2(raw_input(">"))
	objeto2=claseDos()
	objeto2.metodo2()
	objeto2.metodo1()

if __name__ == "__main__"
main()