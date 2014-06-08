#!/bin/bash
#
# Sistema de configuração Layer7 para kernel 2.6.28
# Desenvolvido por Douglas Q. dos Santos
# <douglashx@gmail.com>#
#

Principal()
{
   echo "##############################################"
   echo "#                    OPÇÕES                   "
   echo "##############################################"
   echo "# 1. Primeiro estágio - instalação do kernel  "
   echo "# 2. Estágio 2 - configurações do Iptables    "
   echo "# 3. Gerar um script de firewall de exemplo   "
   echo "# 4. Sair                                     "
   echo "##############################################"
   echo 
   echo -n "Escolha a opção desejada: "
   read OPCAO

   case ${OPCAO} in
   1) INSTALL_KERNEL ;;
   2) INSTALL_IPTABLES ;;
   3) GERA_FIREWALL ;;
   4) exit ;;
   *) "Opção desconhecida." ; echo ; Principal ;;

   esac


}


# COMANDOS GLOBAIS ##################################
CAT=$(which cat)
CP=$(which cp)
RM=$(which rm)
SED=$(which sed)
MV=$(which mv)
APTGET=$(which apt-get)
APTITUDE=$(which aptitude)
CAT=$(which cat)
WGET=$(which wget)
CD=cd
TAR=$(which tar)
MAKE=$(which make)
LN=$(which ln)
PATCH=$(which patch)
MAKE=$(which make)
MODPROBE=$(which modprobe)
DPKG=$(which dpkg)
GZIP=$(which gzip)
REBOOT=$(which reboot)
GPG=$(which gpg)
DPKG_BUILDPACKAGE=$(which dpkg-buildpackage)
APT_KEY=$(which apt-key)
MAKE_KPKG=$(which make-kpkg)
FAKEROOT=$(which fakeroot)
KERNEL="linux-2.6.28"
PATH_SRC=/usr/src
APT=/etc/apt
PACOTES="tar bzip2 fakeroot libncurses5-dev kernel-package dpkg-dev file gcc g++ libc6-dev make patch perl autoconf automake dh-make 
debhelper devscripts fakeroot gnupg g77 gpc xutils lintian quilt libtool libselinux1-dev linuxdoc-tools zlib1g-dev"
KERNEL_URL="http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.28.tar.bz2"
NETFILTER_URL="http://ufpr.dl.sourceforge.net/sourceforge/l7-filter/netfilter-layer7-v2.22.tar.gz"
PROTOCOLS_URL="http://ufpr.dl.sourceforge.net/sourceforge/l7-filter/l7-protocols-2009-05-28.tar.gz"
CONFIG_URL="http://merkel.debian.org/~jurij/2.6.28-1/i386/config-2.6.28-1-686.gz"
#################################################################


INSTALL_KERNEL()
{

echo "#########################################################################"
echo "    APÓS O TÉRMINO DESTE PROCESSO SEU SERVIDOR SERÁ REINICIADO           "
echo "          SE DESEJAR ABORTAR PRESSIONE CTRL+C                            "
echo "          ESTE PROCESSO COMEÇARÁ EM 5 SEGUNDOS                "
echo "#########################################################################"
sleep 5

# AJUSTANDO O APT ##################################################### 
echo "#################AJUSTANDO OS REPOSITÓRIOS###############################"
sleep 5

${MV} ${APT}/sources.list ${APT}/sources.list.bkp

${CAT} <<EOF > ${APT}/sources.list
# Repositório Oficial
deb ftp://ftp.br.debian.org/debian lenny main contrib non-free
deb-src ftp://ftp.br.debian.org/debian lenny main contrib non-free

# Repositório de atualizações frequentes
deb http://volatile.debian.org/debian-volatile lenny/volatile main contrib non-free
deb-src http://volatile.debian.org/debian-volatile lenny/volatile main contrib non-free

# Repositório de atualizações de segurança
deb http://security.debian.org/ lenny/updates main contrib non-free
deb-src http://security.debian.org/ lenny/updates main contrib non-free

# Repositório de atualizações propostas
deb ftp://ftp.br.debian.org/debian lenny-proposed-updates main contrib non-free
deb-src ftp://ftp.br.debian.org/debian lenny-proposed-updates main contrib non-free

# Repositório Backport
deb http://www.backports.org/debian lenny-backports main contrib non-free
deb-src http://www.backports.org/debian lenny-backports main contrib non-free

# Plugins multimídia
deb http://ftp.br.debian.org/debian-multimedia/ lenny main
#deb http://www.debian-multimedia.org lenny main

# PHP5 backport
deb http://packages.dotdeb.org lenny all
deb-src http://packages.dotdeb.org lenny all

EOF

###########ATUALIZANDO AS INFORMAÇÕES DOS NOVOS REPOSITÓRIOS##################
echo "################ATUALIZANDO AS INFORMAÇÕES DOS NOVOS REPOSITÓRIOS########"
sleep 5
${APTITUDE} -y update

###########ATUALIZANDO AS CHAVES DE REPOSITÓRIO (KEYRINGS)####################
${APTITUDE} -y install debian-backports-keyring

${GPG} --keyserver wwwkeys.pgp.net --recv-keys 1F41B907

${APT_KEY} add ~root/.gnupg/pubring.gpg

###########INSTALANDO PACOTES NECESSÁRIOS#####################################
echo "##############INSTALANDO PACOTES NECESSÁRIOS###################"
sleep 5
${APTITUDE} -y install ${PACOTES}

#########ENTRAR O DIRETÓRIO BASE PARA O KERNEL################################
${CD} ${PATH_SRC}

##############BAIXAR O KERNEL E OS OUTROS PACOTES QUE SERÃO CUSTOMIZADO#######
echo "############BAIXANDO O KERNEL E OUTROS PACOTES NECESSÁRIOS############"
${WGET} -c ${KERNEL_URL}
${WGET} -c ${NETFILTER_URL}
${WGET} -c ${PROTOCOLS_URL}
${WGET} -c ${CONFIG_URL}

##############DESEMPACOTAR O KERNEL###########################################
${TAR} -xvjpf ${KERNEL}.tar.bz2

##############CRIAR UM LINK PARA DEFINIR QUAL KERNEL FICARA EM USO#####################
${LN} -sf ${KERNEL} linux


##############DESEMPACOTAR O LAYER7###########################################
${TAR} -xvzpf netfilter-layer7-v2.22.tar.gz
${TAR} -xvzpf l7-protocols-2009-05-28.tar.gz
${GZIP} -dv config-2.6.28-1-686.gz


############APLICANDO O PATCH AO KERNEL#######################################
echo "##############APLICANDO PATCH AO KERNEL########################"
sleep 5
${CD} netfilter-layer7-v2.22
${CP} kernel-2.6.25-2.6.28-layer7-2.22.patch ${PATH_SRC}/linux/
${CD} ${PATH_SRC}/linux
${PATCH} -p1 < kernel-2.6.25-2.6.28-layer7-2.22.patch

###########INSERINDO O MÓDULO DO LAYER7 NO KERNEL#############################
${SED} '/CONFIG_NETFILTER_XT_MATCH_STATE=m/ a \CONFIG_NETFILTER_XT_MATCH_LAYER7=m' ${PATH_SRC}/config-2.6.28-1-686 > 
/tmp/teste2
${SED} '/CONFIG_NETFILTER_XT_MATCH_LAYER7=m/ a \# CONFIG_NETFILTER_XT_MATCH_LAYER7_DEBUG is not set' /tmp/teste2 > /tmp/.config

###########COPIANDO O ARQUIVO DE CONFIGURAÇÃO DO KERNEL#######################
${CP} /tmp/.config ${PATH_SRC}/linux/.config

###########LIMPANDO ARQUIVOS TEMPORÁRIOS DO /TMP##############################
${RM} -rf /tmp/teste2
${RM} -rf /tmp/.config

##############################################################################
##SE QUISER TUNAR O KERNEL DESCOMENTE O TRECHO ABAIXO#########################
#echo
#echo "Networking ---> Networking options ---> Network packet filtering framework (Netfilter) ---> Core Netfilter Configuration ---> <M> layer7 
match suport
#[] Layer 7 debugging output"

#sleep 10

#${MAKE} menuconfig
###############################################################################

###################GERANDO O NOSSO NOVO KERNEL#################################
echo "###########GERANDO O NOSSO NOVO KERNEL######################"
echo "########VAI SER NECESSÁRIO PRESSIONAR 8 VEZES ENTER##########"
sleep 8
echo 
${CD} ${PATH_SRC}/linux 
${MAKE} oldconfig
${MAKE_KPKG} clean
${FAKEROOT} ${MAKE_KPKG} --initrd --append-to-version=-layer7 kernel_image kernel_headers

###############INSTALANDO O NOVO KERNEL########################################
${CD} ${PATH_SRC}
${DPKG} -i linux-image-2.6.28-layer7_2.6.28-layer7-10.00.Custom_i386.deb

echo "################REINICIANDO##########################"
sleep 5
${REBOOT}

}

INSTALL_IPTABLES ()
{

echo "#########################################################################"
echo "    APOS O TERMINO DESTE PROCESSO SEU SERVIDOR SERA REINICIADO           "
echo "          SE DESEJAR ABORTAR PRESSIONE CTRL+C                            "
echo "          ESTE PROCESSO COMEÇARÁ EM 5 SEGUNDOS                "
echo "#########################################################################"
sleep 5

${CD} ${PATH_SRC}

echo "##############BAIXANDO O IPTABLES####################"
sleep 5
${APTGET} source iptables

${CP} -rf ${PATH_SRC}/linux-2.6.28/include/linux/netfilter/xt_layer7.h /usr/include/linux/netfilter/

${CP} -rf ${PATH_SRC}/netfilter-layer7-v2.22/for_older_iptables/iptables-1.4.1.1-for-kernel-2.6.20forward/* ${PATH_SRC}/iptables-
1.4.2/extensions

${CD} ${PATH_SRC}/iptables-1.4.2/
echo "##################COMPILANDO O IPTABLES#################"
sleep 5
${DPKG_BUILDPACKAGE} -rfakeroot

${CD} ${PATH_SRC}
echo "#################INSTALANDO O IPTABLES##################"
sleep 5
${DPKG} -i iptables_1.4.2-6_i386.deb


#########################AJUSTANDO O PREFERENCES############################### 
${MV} ${APT}/preferences ${APT}/preferences.bkp

${CAT} <<EOF > ${APT}/preferences
Package: iptables
Pin: version 1.4.2
Pin-Priority: 1001

EOF

echo "##############INSTALANDO OS PROTOCOLOS DO LAYER7##################"
sleep 5
${CD} ${PATH_SRC}/l7-protocols-2009-05-28/
${MAKE} install

echo "###############CARREGANDO OS MODULOS DO LAYER7#################"
sleep 5
${MODPROBE} ipt_layer7
${MODPROBE} xt_layer7

echo "########################REINICIANDO############################"
sleep 5
${REBOOT}

}

GERA_FIREWALL ()
{
echo "################################################################"
echo "#              Esta sendo gerado um arquivo de firewall         "
echo "#              Que sera gravado no /tmp com o nome de           "
echo "#              firewall.sh um exemplo Simples mas pratico       "
echo "################################################################"
sleep 5

${CAT} <<EOF > /tmp/firewall.sh
#/bin/bash                                  #
#############################################
#      Autor:Douglas Q. dos Santos          #
#      Data:23/10/2009                      #
#      Scripts de firewall                  #
#############################################
#############################################
#Para consultar as portas dos serviços      #
#consulte o arquivo /etc/services           #
#############################################
#Serviços utilizados neste servidor       #
#############################################
LAN=192.168.0.0/24
MODPROBE=\$(which modprobe)
IPT=\$(which iptables)
PROSYS=/proc/sys/net/ipv4
MSN="192.168.0.100"
case \$1 in

   start)
   echo -e "[ \033[01;32m Iniciando Firewall \033[m ]"
   #####################################
   #Ativa o Modulo o iptables       #
   #####################################
   \${MODPROBE} iptable_nat
   #####################################
   #Ativa o Modulo para FTP            #
   #####################################
   \${MODPROBE} ip_conntrack_ftp
   #####################################
   #Ativa o Modulo para ip_conntrack   #
   #####################################
   \${MODPROBE} ip_conntrack
   #####################################
   #Ativa o Modulo do nf_conntrack       #
   #####################################
   \${MODPROBE} nf_conntrack
   #####################################
   #Ativa o repasse de pacotes         #
   #####################################
   echo 1 > \${PROSYS}/ip_forward
   #####################################
   #Desativa o suporte icmp redirects  #
   #####################################
   echo 0 > \${PROSYS}/conf/all/accept_redirects
   #####################################
   #Desativa o ping broadcast          #
   #####################################
   echo 1 > \${PROSYS}/icmp_echo_ignore_broadcasts
   #####################################
   #Desativa source routing            #
   #####################################
   echo 0 > \${PROSYS}/conf/all/accept_source_route
   #####################################
   #Ativa Protecao contra synflood     #
   #####################################
   echo 1 > \${PROSYS}/tcp_syncookies
   ##########################################
   #Habilita a verificacao de rota de origem#
   ##########################################
   for RP in \${PROSYS}/conf/*/rp_filter ; do echo 1 > \$RP ; done
   #####################################
   #Controle de ICMP          #
   #####################################
   echo 0 > \${PROSYS}/icmp_echo_ignore_all
   echo 1 > \${PROSYS}/icmp_echo_ignore_broadcasts
   #####################################
   #Limpa todas as regras          #
   #####################################
   \$IPT -t filter -F
   \$IPT -t nat -F
   \$IPT -t mangle -F
   \$IPT -t filter -X
   \$IPT -t nat -X
   \$IPT -t mangle -X
   #####################################
   #Define politicas default       #
   #####################################
   \$IPT -P INPUT DROP 
   \$IPT -P OUTPUT ACCEPT
   \$IPT -P FORWARD DROP
   #####################################
   #Liberar LoopBack          #
   #####################################
   \${IPT} -A INPUT -i lo -j ACCEPT
   #####################################################################
   #Liberar MSN apenas para os IPs definidos em \${MSN} usando L7PROTO#
   #####################################################################
        #for MSN in \${MSN}
        #do
        #\${IPT} -A FORWARD -m layer7 --l7proto msnmessenger -s \${MSN} -j ACCEPT
        #\${IPT} -A FORWARD -m layer7 --l7proto msnmessenger -d \${MSN} -j ACCEPT
        #done
   #####################################
        # Bloquear protocolos L7PROTO       #
   #####################################
        L7PROTO="ares bittorrent edonkey fasttrack ssh msnmessenger napster"
        for PROTO in \${L7PROTO}
          do
        \${IPT} -A FORWARD -m layer7 --l7proto \${PROTO} -j DROP
        \${IPT} -A INPUT -m layer7 --l7proto \${PROTO} -j DROP
        done
   #####################################
   #Liberar a LAN menos porta 80       #
   #vamos direcionar ela para o squid  #
   #####################################
   \${IPT} -A INPUT -s \${LAN} -j ACCEPT
   \${IPT} -A FORWARD -s \${LAN} -p tcp -m tcp --dport 80 -j DROP
   \${IPT} -A FORWARD -s \${LAN} -j ACCEPT
   #####################################
   #Liberar retorno das conexões       #
   #####################################
   \${IPT} -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
   \${IPT} -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
   ####################################
   #Liberar consulta DNS         #
   ####################################
       \${IPT} -A INPUT -s \${LAN} -p tcp -m tcp --dport 53 -j ACCEPT
    \${IPT} -A INPUT -s \${LAN} -p udp -m udp --dport 53 -j ACCEPT
       \${IPT} -A INPUT -p tcp -m tcp --sport 53 -j ACCEPT
       \${IPT} -A INPUT -p udp -m udp --sport 53 -j ACCEPT
       \${IPT} -A FORWARD -s \${LAN} -p tcp -m tcp --dport 53 -j ACCEPT
       \${IPT} -A FORWARD -s \${LAN} -p udp -m udp --dport 53 -j ACCEPT
   ####################################
   #Libera NTP            #
   ####################################
   \${IPT} -A INPUT -p udp -m udp --sport 123 -j ACCEPT
       \${IPT} -A FORWARD -p udp -m udp --dport 123 -j ACCEPT
   ####################################
   #Libera pings            #
   ####################################
      \${IPT} -A INPUT -p icmp --icmp-type 0 -m limit --limit 1/s -j ACCEPT
       \${IPT} -A INPUT -p icmp --icmp-type 3 -m limit --limit 1/s -j ACCEPT
       \${IPT} -A INPUT -p icmp --icmp-type 5 -m limit --limit 1/s -j ACCEPT
       \${IPT} -A INPUT -p icmp --icmp-type 8 -m limit --limit 1/s -j ACCEPT
       \${IPT} -A INPUT -p icmp --icmp-type 11 -m limit --limit 1/s -j ACCEPT
       \${IPT} -A INPUT -p icmp --icmp-type 12 -m limit --limit 1/s -j ACCEPT
       \${IPT} -A FORWARD -p icmp --icmp-type 0 -m limit --limit 2/s -j ACCEPT
       \${IPT} -A FORWARD -p icmp --icmp-type 3 -m limit --limit 2/s -j ACCEPT
       \${IPT} -A FORWARD -p icmp --icmp-type 5 -m limit --limit 2/s -j ACCEPT
       \${IPT} -A FORWARD -p icmp --icmp-type 8 -m limit --limit 2/s -j ACCEPT
       \${IPT} -A FORWARD -p icmp --icmp-type 11 -m limit --limit 2/s -j ACCEPT
       \${IPT} -A FORWARD -p icmp --icmp-type 12 -m limit --limit 2/s -j ACCEPT

   ######################################
   #Negar Identidade           #
   ######################################
   \${IPT} -A INPUT -p tcp -m tcp --dport 113 -j REJECT --reject-with tcp-reset
   #############################################
   #Reset em conexões para portas desconhecidas#
   #############################################
   \${IPT} -A INPUT -p tcp -j REJECT --reject-with tcp-reset
   #############################################
   #NAT da rede interna             #
   #############################################
   \${IPT} -t nat -A POSTROUTING -t nat -s \${LAN} -j MASQUERADE
   #############################################
   #Fazer Proxy Transparente          #
   #############################################
   \${IPT} -t nat -A PREROUTING -s \${LAN} -p tcp --dport 80 -j REDIRECT --to-port 3128

   echo -e "[ \033[01;32m Firewall Iniciado  \033[m ]"
   ;;
   stop)
   echo -e "[ \033[01;31m Parando Firewall ... \033[m ]";
   ####################################
   #Define políticas default.         #
   ####################################
   \$IPT -P INPUT ACCEPT
   \$IPT -P OUTPUT ACCEPT
   \$IPT -P FORWARD ACCEPT
   ####################################
   #Limpando todas as regras          #
   ####################################
   \$IPT -t filter -F
   \$IPT -t nat -F
   \$IPT -t mangle -F
   \$IPT -t raw -F
   ####################################
   echo -e "[ \033[01;31m Firewall Parado \033[m ]";
   ;;

   status)
   echo -e "[ \033[01;32m 
######################################################################################## 
\033[m ]";
   echo -e "[ \033[01;31m *******************************Table Filter********************************************* 
\033[m ]";
   \$IPT -t filter -L -n
   echo -e "[ \033[01;32m 
######################################################################################## 
\033[m ]";
   echo -e "[ \033[01;31m ********************************Table Nat*********************************************** 
\033[m ]";
   \$IPT -t nat -L -n
   echo -e "[ \033[01;32m 
######################################################################################## 
\033[m ]";
   echo -e "[ \033[01;31m ********************************Table Mangle******************************************** 
\033[m ]";
   \$IPT -t mangle -L -n
   echo -e "[ \033[01;32m 
######################################################################################## 
\033[m ]";
   echo -e "[ \033[01;31m ********************************Table Raw*********************************************** 
\033[m ]";
   \$IPT -t raw -L -n

   ;;

   restart)
    \$0 stop
    \$0 start
   ;;

   *)
   echo "Opções Validas:(start|stop|restart|status)"
   ;;

esac
EOF
} 

Principal
