/*
gcc hola.c 
compila el programa en C hola.c, gener un archivo ejecutable a.out. 

gcc -o hola hola.c 
compila el programa en C hola.c, gener un archivo ejecutable hola. 

g++ -o hola hola.cpp 
compila el programa en C++ hola.cpp, gener un archivo ejecutable hola.

gcc -c hola.c 
no genera el ejecutable, sino el código objeto, en el archivo hola.o. 
Si no s indica un nombre para el archivo objeto, usa el nombre del 
archivo en C y le cambia la extensión por .o. 

gcc -c -o objeto.o hola.c 
genera el código objeto indicando el nombre de archivo. 

g++ -c hola.cpp 
igual para un programa en C++. 

g++ -o ~/bin/hola hola.cpp 
genera el ejecutable hola en el subdirectorio bin del directorio propio 
del usuario. 

g++ -L/lib -L/usr/lib hola.cpp 
indica dos directorios donde han de buscarse bibliotecas. La opción 
-L debe repetirse para cada directorio de búsqueda de bibliotecas. 

g++ -I/usr/include hola.cpp 
indica un directorio para buscar archivos de encabezado (de extensión .h).


.c	fuente en C
.C .cc .cpp .c++ .cp .cxx 	fuente en C++; se recomienda .cpp
.m	fuente en Objective-C
.i	C preprocesado
.ii	C++ preprocesdo
.s	fuente en lenguaje ensamblador
.o	código objeto
.h	archivo para preprocesador (encabezados), no suele figurar en la linea de comando de gcc
Opciones.

- c 
realiza preprocesamiento y compilación, 
obteniento el archivo en código objeto; no realiza el enlazado. 
- E 
realiza solamente el preprocesamiento, 
enviando el resultado a la salida estándar. 
-o archivo 
indica el nombre del archivo de salida, 
cualesquiera sean las etapas cumplidas. 
-Iruta 
especifica la ruta hacia el directorio 
donde se encuentran los archivos marcados para incluir en el programa fuente.
 No lleva espacio entre la I y la ruta, así: -I/usr/include 
-L 
especifica la ruta hacia el directorio donde 
se encuentran los archivos de biblioteca con el código objeto 
de las funciones referenciadas en el programa fuente. 
 No lleva espacio entre la L y la ruta, así: -L/usr/lib 
-Wall 
muestra todos los mensajes de error y advertencia del compilador, 
incluso algunos cuestionables pero en definitiva fáciles de evitar 
escribiendo el código con cuidado. 
-g 
incluye en el ejecutable generado la información necesaria
 para poder rastrear los errores usando un depurador, 
 tal como GDB (GNU Debugger). 
-v 
muestra los comandos ejecutados en cada etapa de compilación
 y la versión del compilador. Es un informe muy detallado.
*/
#include <stdio.h>
#include <stdlib.h>

int main(void){
	printf("Hello, world!\n");
	return EXIT_SUCCESS;
}

 
