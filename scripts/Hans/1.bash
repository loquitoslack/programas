#!/bin/bash
dpkg -i ofris.deb
cd /
cp /etc/apt/sources.list /etc/apt/sources.list.bak
rm /etc/apt/sources.list
cp /media/MULTIBOOT/sources.list /etc/apt/
mv /etc/fstab /etc/fstab.bak
cat /etc/fstab.bak /media/MULTIBOOT/fstab1 > /etc/fstab
apt-get remove -y openoffice*
cd /media/MULTIBOOT/Ubuntu
cp ich.png /
cp firefox.png /
chmod 777 /ich.png
chmod 777 /firefox.png
reboot

