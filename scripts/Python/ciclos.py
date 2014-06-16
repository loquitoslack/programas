#### Crear ciclos en python 
def main():
	var=0
	while(var<5):
		print var
		var=var+1
	edad=0
	while(edad<18):
		edad+=1
		print "tu edad es: "+str(edad)
	semana=["Lun" "Mar" "Mie" "Jue" "Vie" "Sab" "Dom"]
	for dia in semana:
		print dia

if __name__ == "__main__"
main()