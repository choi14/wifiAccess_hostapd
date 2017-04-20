#!/bin/bash

#sudo service network-manager start
#sleep 2

sudo service network-manager stop
sleep 2

sudo iw reg set US
sudo ifconfig wlp2s0 10.0.0.1 netmask 255.255.255.0

#sudo ./hostapd hostapd.conf -d > hostapd_debug_log.txt

sudo ./hostapd hostapd.conf

