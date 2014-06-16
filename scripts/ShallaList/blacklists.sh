#!/bin/sh
#
# squidGuard blacklists - download & install script to
# download blacklists from Shalla Secure Services @
# http://squidguard.shalla.de/Downloads/shallalist.tar.gz
#
# created by Steve Olive - oz.ollie[at]gmail.com
# ver 0.8 20071204 15:05 GMT+10
# Creative Commons Attribution-Share Alike 3.0 License
# http://creativecommons.org/licenses/by-sa/3.0/
#
# This script is designed and tested on Ubuntu Server 7.10
# but should work on any *nix server
#
# There are a number of customisations allowing for local
# black and white lists in addition to the blacklists that
# are downloaded from Shalla Secure Services. These files
# are saved in "/root/squidguard" and this script is 
# located in "/root/bin".
#
# Create the directories "/root/squidguard/black" and
# "/root/squidguard/white" and then the files "domains"
# and "urllist" in each of the directories. Add the domains
# and URLs to the appropriate files in either the "black" or
# "white" directories.
#
# Add the appropriate black and white directory information
# to your "squidguard.conf" file and add "white !black" to
# the start of your filtering selections.
#
# Please feel free to edit this file for your server and
# environment. The blackand white directories could also be
# located in "/var/lib/squidguard".
#
cd /root/squidguard
# download latest file - overwrite any existing file
echo 'Downloading new blacklists ...'
wget -N http://squidguard.shalla.de/Downloads/shallalist.tar.gz -a /var/log/shalla.log
# extract blacklists
tar -zxf shallalist.tar.gz
echo 'New list downloaded'
# remove old databases
rm -Rf /var/lib/squidguard/db/*
# copy blacklists to db home
cp -R /root/squidguard/BL/* /var/lib/squidguard/db
# create whitelist directory and copy files
mkdir /var/lib/squidguard/db/white
cp -R /root/squidguard/white/* /var/lib/squidguard/db/white
# create blacklist directory and copy files
mkdir /var/lib/squidguard/db/black
cp -R /root/squidguard/black/* /var/lib/squidguard/db/black
# copy porn expressions list and rename
cp /root/squidguard/squidGuard_porn_expressions /var/lib/squidguard/db/porn
mv /var/lib/squidguard/db/porn/squidGuard_porn_expressions /var/lib/squidguard/db/porn/expressions
# build domains + urls db, then change ownership to squid user
echo 'Build databases ...'
/usr/bin/squidGuard -C all
echo 'Database builds complete'
chown -R proxy:proxy /var/lib/squidguard/db
squid -k reconfigure
echo 'Squid Proxy Server reconfigured'
rm -Rf /root/squidguard/BL
