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


###########################################################
apt-get install -y --force-yes fakeroot libncurses5-dev kernel-package dpkg-dev file gcc g++ libc6-dev make patch perl autoconf automake dh-make debhelper devscripts fakeroot gnupg gpc xutils lintian quilt libtool libselinux1-dev linuxdoc-tools zlib1g-dev 
cd /usr/src
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.32.tar.bz2
tar -xvjpf linux-2.6.32.tar.bz2
ln -sf linux-2.6.32 linux 
wget http://download.sourceforge.net/l7-filter/netfilter-layer7-v2.22.tar.gz
tar -xvzpf netfilter-layer7-v2.22.tar.gz 
cd netfilter-layer7-v2.22
cp kernel-2.6.25-2.6.28-layer7-2.22.patch /usr/src/linux/
cd /usr/src/linux
patch -p1 < kernel-2.6.25-2.6.28-layer7-2.22.patch 
cp /boot/config-2.6.32-5-amd64 /usr/src/linux/.config
make menuconfig 

Networking Support > Networking Options > Network packet filtering framework (Netfilter) > Core Netfilter Configuration >
<M> "layer7" match support
[*]   Layer 7 debugging output

make-kpkg clean
fakeroot make-kpkg --initrd --append-to-version=-custom kernel_image kernel_headers

cd /usr/src
dpkg -i linux-image-2.6.32-custom_2.6.32-custom-10.00.Custom_amd64.deb
dpkg -i linux-headers-2.6.32-custom_2.6.32-custom-10.00.Custom_amd64.deb