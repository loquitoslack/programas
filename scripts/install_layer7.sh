#!/bin/bash

function _install_layer7(){
apt-get install module-assistant
m-a prepare
apt-get install kernel-package quilt autoconf automake libtool libncurses5-dev pkg-config checkinstall build-essential zlib1g-dev iptables-dev
aptitude purge iptables-dev
}

function _download_layer7(){ 
cd /usr/src
wget http://ufpr.dl.sourceforge.net/sourceforge/xtables-addons/xtables-addons-1.17.tar.bz2
wget http://ufpr.dl.sourceforge.net/sourceforge/l7-filter/netfilter-layer7-v2.21.tar.gz
wget http://ufpr.dl.sourceforge.net/sourceforge/l7-filter/l7-protocols-2009-05-28.tar.gz
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.30.1.tar.bz2
http://ftp.netfilter.org/pub/iptables/iptables-1.4.4.tar.bz2
}


function _descomprimir_layer7(){
tar -jvxf xtables-addons-1.17.tar.bz2
tar -zvxf netfilter-layer7-v2.21.tar.gz
tar -zvxf l7-protocols-2009-05-28.tar.gz
tar -jvxf linux-2.6.30.1.tar.bz2
tar -jvxf iptables-1.4.4.tar.bz2
}

function _linksimbolicos_layer7(){
ln -s xtables-addons-1.17 xtables-addons
ln -s linux-2.6.30.1 linux
ln -s iptables-1.4.4 iptables
}

function _parcharkernel_layer7(){
cd /usr/src/linux

}
