#!/bin/bash
#   aUbuntu - Full install Ubuntu 
#
#   Copyright (C) Edwin Enrique Flores Bautista <loquitoslack@gmail.com>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2, or (at your option)
#   any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
#   RELEASE: 20120518
# Autor: Edwin Enrique Flores Bautista
# Fecha: 27-05-2012
# Observaciones: Automatización Instalación Ubuntu 10.04 

function _title(){
clear 0
echo '.____    .__              '
echo '|    |   |__| ____  __ _____  ___'
echo '|    |   |  |/    \|  |  \  \/  /'
echo '|    |___|  |   |  \  |  />    < '
echo '|_______ \__|___|  /____//__/\_ \'
echo '        \/       \/            \/'
sleep 0.3 
}

function _menu(){
echo "a) Update/Upgrade/Configurar Ubuntu" 
echo "b) Instalar Printer TMU950 "
echo "c) Intalar Printer TMU110"
echo "d) Help Me!!!!!!"
echo "e) exit"
echo -ne "escoje tu opcion --> "
read option 
case "$option" in
    "a")
 	instalar_ubuntu
    ;;
    "b")
 	instalar_driver_TMU950
    ;;
    "c")
	instalar_driver_TMU110 
    ;;
    "d")
	#### Falta
	;;
	"e")
       exit 0; 
	;; 
    *)
esac
}


actualiza_source() {
cp -rfv /etc/apt/sources.list /etc/apt/sources.list.old
cat > /etc/apt/sources.list << "EOF"
deb http://ubuntu.ich.edu.pe/ubuntu.wikimedia.org/ubuntu/ lucid main multiverse restricted universe
deb http://ubuntu.ich.edu.pe/ubuntu.wikimedia.org/ubuntu/ lucid-updates main multiverse restricted universe
deb http://ubuntu.ich.edu.pe/ubuntu.wikimedia.org/ubuntu/ lucid-security main multiverse restricted universe
deb http://ubuntu.ich.edu.pe/ubuntu.wikimedia.org/ubuntu/ lucid-backports main multiverse restricted universe
EOF
}

actualiza_sistema(){
apt-get update && apt-get upgrade -y --force-yes 
}

genera_software(){
cat > /tmp/software.txt << "EOF"  
non-free-codecs gstreamer0.10-ffmpeg libdvdread4 vlc
rar unace p7zip-full p7zip-rar lha arj  
htop
EOF
}

remueve_listado(){
cat > /tmp/remueve.txt << EOF
gnome-games-common gbrainy f-spot gwibber tsclient transmission-common transmission-gtk vinagre empathy evolution pitivi
EOF
}

instala_paquetes(){
#genera lista de SW a instalar
genera_software
paquete=(`cat /tmp/software.txt`)
i=0
while [ $i -lt ${#paquete[@]} ]; do
	apt-get install -y --force-yes ${paquete[$i]}
	i=$((1+$i))
done
}

remueve_paquetes(){
remueve_listado
i=0
paquete=(`cat /tmp/remueve.txt`)
while [ $i -lt ${#paquete[@]} ]; do
	apt-get remove -y --force-yes --purge ${paquete[$i]}
	i=$((1+$i))
	done
}

instalar_ubuntu(){
actualiza_source
actualiza_sistema
instala_paquetes
remueve_paquetes
}

instalar_driver_TMU950(){
apt-get install php5 php5-gd php5-cli apache2 -y --force-yes
wget -c "http://ubuntu.ich.edu.pe/public/recaudacion.tar.gz"
tar -zxvf recaudacion.tar.gz -C /var/www/
}

