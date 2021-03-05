#Use this script to quickly block an IP address via iptables

#Check that user is root
if [ "$EUID" -ne 0 ]
  then echo "RUN ONLY WITH SUDO"
  exit
fi

#Specify the IP you want to block
echo Input IP you want to block: 
read ip

#Creates rules for blocking inbound, outbound, and forward traffic
#Note that these rules are assigned to line 1 so they will always check the IP before admitting connection
iptables -I INPUT 1 -s $ip  -j DROP
iptables -I OUTPUT 1 -s $ip -j DROP
iptables -I FORWARD 1 -s $ip -j DROP

echo The IP $ip has been blocked from inbound, outbound, and forward traffic. 

