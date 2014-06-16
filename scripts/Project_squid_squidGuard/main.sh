#!/bin/bash
domain=${1:?'No se admiten dominios nulos'}
categorie=${2:-"NULL"}
Draiz=/var/lib/squidguard/db 
Dtmp=/tmp
vinicial=0      #Define primera ejecución del script
 
function _busqueda_aSquidguard(){
 domain=$1
 grep -n -R -E "^(?|\+)$domain$" $Draiz > $Dtmp/domainquery.txt
 cat $Dtmp/domainquery.txt
while read linea; do
dgraiz=`echo $linea | awk -F : '{print $1}'`
dignum=`echo $linea | awk -F : '{print $2}'`
digdom=`echo $linea | awk -F : '{print $3}'`
digcat=`echo $linea | awk -F : '{print $4}'`
done<$Dtmp/domainquery.txt 
 #categorie=`cat $Dtmp/domainquery.txt | awk -F : '{print $1}' | awk -F "/" '{print $6}'`
 #sed -e "s/$/:\$categorie/" $Dtmp/domainquery.txt
}

_busqueda_aSquidguard $1
