#!/bin/sh

##################################
# Configure These Options
##################################

###################################
# mail address for status updates
#  - This is used to email you a status report
###################################
MAILADDR="ecarrasco@ich.edu.pe"

###################################
# HOSTNAME
#  - This is also used for reporting
###################################
HOSTNAME="KOHA"

###################################
# root directory to for backup stuff
###################################
ARCHIVEROOT="/backup/DATA"
BDROOT="/backup/BD"
BDTMP="/backup/TMP"

##################################
# LOG para la sincronizacion
#################################
LOG="/backup/backup.log"

# directory which we save incremental changes to
#INCREMENTDIR=`date +%Y-%m-%d`
DATE=`date +%d-%m-%Y`
DATE2=`date --date '90 days ago' +%d-%m-%Y`
do_backup_data()
{
   echo "Backup Realizado el dia $DATE en $HOSTNAME:" >> $LOG
   echo "-------------------------" >> $LOG
   echo "" >> $LOG
   echo "comprimimiendo koha" >> $LOG
   tar -czvf $ARCHIVEROOT/koha-$DATE.tar.gz /usr/share/koha
   echo "Eliminando anteriores" >> $LOG
   rm -rf $ARCHIVEROOT/koha-$DATE2.tar.gz
   echo "####### FIn ##########" >> $LOG
   echo "" >> $LOG
}

do_backup_bd()
{
   echo "Backup BD Realizado el dia $DATE en $HOTSNAME" >> $LOG
   echo "----------------------------" >> $LOG
   DBS="$(mysql -u root -pTuadoo4u -Bse 'show databases')"
   echo "Ingresando a: $BDTMP" >> $LOG
   cd $BDTMP
   for bd in $DBS
   do
    if [ ! -f $bd-$DATE.tar.gz ]
    then
      echo "Backup de: $bd" >> $LOG
      mysqldump -uroot -pTuadoo4u -R $bd > $bd-$DATE.sql
      echo "comprimiendo : $bd-$DATE.sql" >> $LOG
      tar -czvf $bd-$DATE.tar.gz $bd-$DATE.sql
      echo "copiando $BDTMP/$bd-$DATE.tar.gz -> $BDROOT/"
      cp $BDTMP/$bd-$DATE.tar.gz $BDROOT/
      echo "Eliminando : $bd-$DATE.sql" >> $LOG
      rm -rf $bd-$DATE.sql
    fi
    echo "Eliminando : $BDROOT-$bd.$DATE2.tar.gz" >> $LOG
    rm -rf $BDROOT/$bd-$DATE2.tar.gz
   done
   echo "####### FIn ##########" >> $LOG
   echo "" >> $LOG
}