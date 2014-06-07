#!/bin/bash
#   This doc is free; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2, or (at your option)
#   any later version.
#
#   This doc is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# RELEASE: 20140530
# Autor: exonix 
# Autor: Edwin Enrique Flores Bautista
# email: loquitoslack@gmail.com 
# blog: loquitoslack.blogspot.com 
# Fecha: 31-05-12
# VER=20140531

######### Define Variables ################

SARG=/usr/bin/sarg
CONFIG=/etc/sarg/sarg.conf
HTMLOUT=/var/www/squid-reports 
PAGETITLE='Access Reports on proxy'
LOGOIMG=/sarg/images/sarg.png
LOGOLINK=http://4.bp.blogspot.com/-Y1GEIePzPOQ/T_yjwuhfw8I/AAAAAAAAAAg/bIRt8AuoFrc/s1600/LOGO+OFICIAL+UCH.png
DAILY=Daily
WEEKLY=Weekly
MONTHLY=Monthly
EXCLUDELOG1='SARG: No records found'
EXCLUDELOG2='SARG: End'
TMPFILE=/tmp/tmp.ws6bA0PJp4
ERRORS=/tmp/tmp.ws6bA0PJp4.errors
TODAY=`date --date today +%d/%m/%Y`
YESTERDAY=`date --date '1 day ago' +%d/%m/%Y`
WEEKAGO=`date --date '1 week ago' +%d/%m/%Y`
WEEKAGO01=`date --date '1 month ago' +01/%m/%Y`
WEEKAGO31=`date --date '1 month ago' +31/%m/%Y`
MONTHAGO=echo "$WEEKAGO01-$WEEKAGO31"
WEEKLYOUT=/var/lib/sarg/Weekly
mkdir -p /var/lib/sarg/Weekly
create_index_html(){
echo -e '
<html>\n  
<head>\n  
<title>Access Reports on proxy</title>\n
</head>\n  
<body>\n  
<div align=center>\n    
<a href=http://proxy/><img border=0 src=/sarg/images/sarg.png></a>\n 
<table border=0 cellspacing=6 cellpadding=7>\n 
    <tr>\n        
      <th align=center nowrap>
        <b><font face=Arial size=4 color=green>Access Reports on proxy</font></b>
      </th>\n      
    </tr>\n      
    <tr>\n        
      <td align=center bgcolor=beige><font face=Arial size=3>
        <a href=Daily>Daily</a>
        </font>
      </td>\n      
    </tr>\n      
    <tr>\n        
     <td align=center bgcolor=beige> <font face=Arial size=3><a href=Weekly>Weekly</a></font>
     </td>\n      
    </tr>\n      
    <tr>\n        
    <td align=center bgcolor=beige><font face=Arial size=3>
      <a href=Monthly>Monthly</a></font>
    </td>\n      
    </tr>\n    
  </table>\n  
  </div>\n  
  </body>\n  
</html>'
} 

today ()
{
  DAILYOUT=$HTMLOUT/$DAILY
  mkdir -p $DAILYOUT
  create_index_html
  $SARG -f $CONFIG -d $TODAY -o $DAILYOUT >$ERRORS 2>&1
  exclude_from_log
}
daily ()
{
  DAILYOUT=$HTMLOUT/$DAILY
  mkdir -p $DAILYOUT
  create_index_html
  $SARG -f $CONFIG -d day-1 -o $DAILYOUT >$ERRORS 2>&1
  exclude_from_log
}
weekly ()
{
  WEEKLYOUT=$HTMLOUT/$WEEKLY
  mkdir -p $WEEKLYOUT
  create_index_html
  $SARG -f $CONFIG -d week-1 -o $WEEKLYOUT >$ERRORS 2>&1
  exclude_from_log
}
monthly ()
{
  MONTHLYOUT=$HTMLOUT/$MONTHLY
  mkdir -p $MONTHLYOUT
  create_index_html
  $SARG -f $CONFIG -d month-1 -o $MONTHLYOUT >$ERRORS 2>&1
  exclude_from_log
}