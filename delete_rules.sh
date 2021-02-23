#This is for if you need to delete a rule from all three zones

#Specify line
echo Input the line number of the rule. If you just used the block ip script or close iptable script, the line number is 1.
read line

iptables -D INPUT $line
iptables -D OUTPUT $line
iptables -D FORWARD $line

echo Done
