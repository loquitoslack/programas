#!/bin/bash
apt-get install -y ocsinventory-agent
rm /etc/ocsinventory/ocsinventory-agent.cfg
cp ocsinventory-agent.cfg /etc/ocsinventory/ocsinventory-agent.cfg
cp /etc/rc.local /etc/rc.local.bak
rm /etc/rc.local
cp rc.local /etc/rc.local
