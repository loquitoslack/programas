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

_hardening_configuration