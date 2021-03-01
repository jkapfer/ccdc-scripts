#This script is used to quickly deny all inbound and outbound traffic through your iptable to cut off any persitence
iptables -I INPUT 1 -j DROP
iptables -I FORWARD 1 -j DROP
iptables -I OUTPUT 1 -j DROP
