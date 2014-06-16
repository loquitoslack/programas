#!/bin/bash

function _check_internet(){
if `ping -c 1 www.google.com.pe &>/dev/null &`; then
  for((i=0;i<3;i++)); do
	echo -ne "."
	sleep 0.5
  done
  echo -ne "\n"
else 
  exit 0
fi

}

function _source_list(){
cat > /etc/apt/source.list<<"EOF"
deb http://ftp.us.debian.org/debian wheezy main contrib non-free
deb http://ftp.us.debian.org/debian/ wheezy-updates main contrib non-free
EOF
}

function _update_upgrade(){
apt-get update -y --force-yes && apt-get upgrade -y --force-yes
}

function _install_packages(){
paquetes="squid3 shorewall bind9 ntpdate openvpn dansguardian nmap iftop htop vim ssh isc-dhcp-server dnsutils clamav clamav-daemon nagios-nrpe-server bmon resolvconf sarg snmpd sudo screen links"
apt-get install -y --force-yes $paquetes 
}

function _configuration_packages(){
 freshclam
 usermod -a -G dansguardian clamav
 /etc/init.d/clamav-daemon start
 /etc/init.d/squid3 stop 
 /usr/sbin/squid3 -z 
 chow -R proxy.proxy /var/spool/exenta/
 update-rc.d raptor defaults
}

function _configuration_archives(){
cat>/root/.vimrc<<"EOF"
syntax on
set hls 
set ic
set is
set ru
set nu
set smd 
colorscheme evening
EOF

cat>>/root/.bashrc<<"EOF"
alias ts="tail -f /var/log/squid3/access.log"
alias rts="tail -f /var/log/raptor/access.log"
alias sts="tail -f /var/log/dansguardian/access.log"
export EDITOR=vim
EOF
}

function _download_scripts(){
wget -c "http://ubuntu.ich.edu.pe/pub/caching/debian7/x86_64/check_dns.sh" 
wget -c "http://ubuntu.ich.edu.pe/pub/caching/debian7/x86_64/check_raptor.sh" 
mv -v check_* /usr/local/bin/. 
chmod 744 /usr/local/bin/. 
}

function _configuration_crontab(){
cat >> /etc/crontab<<"EOF"
*/5 * * * * root /usr/sbin/ntpdate 2.pool.ntp.org
*/1 * * * *  root /usr/local/bin/check_dns.sh 
*/5 * * * * root /usr/local/bin/check_raptor.sh
EOF
}

function _download_configuration(){
Server=192.168.1.91
wget -c "http://$Server/programas.tar.gz" 
tar -zxvf programas.tar.gz -C /tmp 
cp -rfv /tmp/programas/* /. 
rm -rfv programas
rm -rfv programas.tar.gz
}


function _hardening_configuration(){
useradd -s /bin/bash -c "support e-nteractiva SAC" -g users -G sudo -m -d /home/support support
echo support:k4rr45k0 | chpasswd

# Configuracion de sudo para proveedor
cat >> /etc/sudoers <<EOF
support ALL=(root) ALL
EOF

# Deshabilitar el inicio de sesion de root en consolas locales
echo "Deshabilitando el inicio de sesion de root en los tty"
sed -i -r -e '/^tty[[:digit:]]+/s/^/#/g' /etc/securetty

# Limitar los accesos SSH
echo "Deshabilitando el inicio de sesion de root via SSH"
sed -r -i -e '/PermitRootLogin[[:blank:]]+yes/s/^#(.*)[[:blank:]]+yes$/\1 no/g' /etc/ssh/sshd_config

echo "Limitando los usuarios autorizados a ingresar via SSH"
cat >> /etc/ssh/sshd_config <<EOF

# Usuarios permitidos a ingresar via SSH
AllowUsers support root@10.255.255.*
EOF

echo "Configurando banner disuasivo SSH"
sed -r -i -e '/Banner[[:blank:]]+\/etc\/issue.net/s/^.*$/# Banner disuasivo/g' /etc/ssh/sshd_config
sed -r -i -e '/Banner disuasivo/aBanner \/etc\/ssh\/banner.txt' /etc/ssh/sshd_config

cat >> /etc/ssh/banner.txt <<EOF
***************************************************************************************************

ADVERTENCIA: 
Este es un sistema privado!!! Todos los intentos de conexion son registrados y auditados. 
Si usted no esta autorizado, desconectese de este equipo inmediatamente. 

***************************************************************************************************
EOF

/etc/init.d/ssh restart 

# Configurando segurida de las sesiones de shell
echo "Configurando segurida de las sesiones de shell"
cat >> /etc/profile <<EOF

# Formato del historial de comandos 
export HISTTIMEFORMAT="%d/%m/%Y %H:%M:%S " 

# Tamano maximo del historial de comandos 
export HISTSIZE=2000

# Inactividad maxima de sesion antes de ser cerrada 
export TMOUT=300

export EDITOR=vim
EOF

# Limitando el uso de cron y at
echo "Limitando el uso de cron y at"
echo root > /etc/cron.allow
echo root > /etc/at.allow

}

function _define_interfaces(){
cat > /etc/network/interfaces<<"EOF"
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface

auto eth0
iface eth0 inet static
address 192.168.1.10
netmask 255.255.255.0
gateway 192.168.1.1 
dns-nameservers 8.8.8.8

auto eth0:0
iface eth0:0 inet static
address 192.168.100.1 
netmask 255.255.255.0 

auto eth1
iface eth1 inet static
address 172.16.1.1
netmask 255.255.255.0

EOF
}

function _reboot(){
reboot -f 
}

function _install_script(){
_source_list
_update_upgrade
_install_packages
_configuration_archives
_download_scripts
_configuration_crontab
_download_configuration
_configuration_packages
_hardening_configuration
_define_interfaces
_reboot
}
