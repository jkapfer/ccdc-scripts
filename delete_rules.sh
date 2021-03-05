#This is for if you need to delete a rule from all three zones

#Check that user is root
if [ "$EUID" -ne 0 ]
  then echo "RUN ONLY WITH SUDO"
  exit
fi

#Specify line
echo Input the line number of the rule. If you just used the block ip script or close iptable script, the line number is 1.
read line

iptables -D INPUT $line
iptables -D OUTPUT $line
iptables -D FORWARD $line

echo Done
