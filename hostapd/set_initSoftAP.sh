#!/bin/bash

sudo service network-manager stop
sleep 1

# e.g., $1=wlan0 $2=eth0
#Initial wifi interface configuration
sudo iw reg set US
sudo ifconfig $1 10.0.0.1 netmask 255.255.255.0
sleep 1

###########Start DHCP, comment out / add relevant section##########
#Thanks to Panji
#Doesn't try to run dhcpd when already running
if [ "$(ps -e | grep dhcpd)" == "" ]; then
sudo dhcpd $1 &
fi

###########
#Enable NAT
sudo iptables --flush
sudo iptables --table nat --flush
sudo iptables --delete-chain
sudo iptables --table nat --delete-chain
sudo iptables --table nat --append POSTROUTING --out-interface $2 -j MASQUERADE
sudo iptables --append FORWARD --in-interface $1 -j ACCEPT
 
#Thanks to lorenzo
#Uncomment the line below if facing problems while sharing PPPoE, see lorenzo's comment for more details
#iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
 
sudo sysctl -w net.ipv4.ip_forward=1

#start hostapd
#hostapd /etc/hostapd/hostapd.conf 1>/dev/null
sudo ./hostapd hostapd.conf
sudo killall dhcpd
