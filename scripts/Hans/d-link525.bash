#!/bin/bash
cp DWA-525.zip /opt/
cd /opt/
unzip DWA-525.zip
cd driver
make
make install
reboot
