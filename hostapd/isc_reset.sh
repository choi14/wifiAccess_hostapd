sudo rm -rf /var/lib/dhcp /run/dhcp-server
sleep 1
sudo apt-get install --reinstall isc-dhcp-server
