#This script is used to quickly deny all inbound and outbound traffic through your iptable to cut off any persitence

#Check that user is root
if [ "$EUID" -ne 0 ]
  then echo "RUN ONLY WITH SUDO"
  exit
fi

iptables -I INPUT 1 -j DROP
iptables -I FORWARD 1 -j DROP
iptables -I OUTPUT 1 -j DROP
