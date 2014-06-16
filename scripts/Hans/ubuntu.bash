#!/bin/bash
rm /etc/apt/sources.list
cp sources.list /etc/apt/
mv /etc/fstab /etc/fstab.bak
cat /etc/fstab.bak fstab1 > /etc/fstab
apt-get remove -y openoffice*
apt-get update

