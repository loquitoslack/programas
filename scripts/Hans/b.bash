#!/bin/bash
dpkg -i chromium*.deb
apt-get remove -y firefox
cp firefox-3.6.20.tar.bz2 /opt/
cd /opt/
tar -jxvf firefox-3.6.20.tar.bz2
rm firefox-3.6.20.tar.bz2
cd /usr/local/bin
ln -s /opt/firefox/firefox
apt-get update -f
apt-get upgrade -y -f
cd /home/usuario/Escritorio/Soporte/Programas/Linux/Ubuntu\ 10.04/Java/
dpkg -i *.deb
apt-get update
cd /home/usuario/Escritorio/Soporte/Programas/Linux/Ubuntu\ 10.04/Libreoffice
bash Instalar.bash
cd /home/usuario/
apt-get upgrade -y
apt-get -f install
reboot
