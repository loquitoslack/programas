#!/bin/bash
cd /
apt-get update
apt-get install -y firefox-locale-es
apt-get install -y flashplugin-nonfree
apt-get install -y vim
apt-get install -y ssh
apt-get update
cd /home/usuario/Escritorio/Soporte/Programas/Linux/Ubuntu\ 10.04/Libreoffice
bash Instalar.bash
cd /home/usuario/
apt-get upgrade -y --fix-missing
