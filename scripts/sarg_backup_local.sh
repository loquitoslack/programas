#!/bin/bash
ARCHIVEROOT=/backup
SARGROOT=/var/www/squid-reports
SARGTIME=sarg.`date +%d%b%Y`
if [ ! -d $ARCHIVEROOT ]; then 
 mkdir $ARCHIVEROOT 
fi
function empaqueta_tar() {
        tar cvf $ARCHIVEROOT/$SARGTIME.tar $SARGROOT/Daily/`date +%Y%b%d-%Y%b%d`
        tar --append --verbose --file=$ARCHIVEROOT/$SARGTIME.tar $SARGROOT/index.html
        tar --append --verbose --file=$ARCHIVEROOT/$SARGTIME.tar $SARGROOT/Daily/index.html
        tar --append --verbose --file=$ARCHIVEROOT/$SARGTIME.tar $SARGROOT/Daily/images/

}

function comprime_tar() {
        bzip2 $ARCHIVEROOT/$SARGTIME.tar -v
}

empaqueta_tar
comprime_tar 

