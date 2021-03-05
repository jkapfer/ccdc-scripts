#!/bin/sh

##
# Devin Ingersoll
# 3/2/2021
# Hardens ssh service based using premade sshd_config file
##

## check if current dir is cloned folder
CURDIR=$(pwd | awk -F/ '{print $(NF)}')
if [ "CURDIR" != "ccdc-scripts" ];then
  echo "only use in repo's root dir"
  exit
fi


## make sure ssh is installed
if [ ! -z $(command -v apt) ]; then sudo apt install openssh-server; fi
if [ ! -z $(command -v dnf) ]; then sudo dnf install openssh-server; fi
if [ ! -z $(command -v yum) ]; then sudo yum install openssh-server; fi
if [ ! -z $(command -v pacman) ]; then sudo pacman -S install openssh-server; fi


## backup old sshd config & copy over new config and banner
mv /etc/ssh/sshd_config /etc/ssh/OLDsshd_config
mkdir /etc/ssh/sshd_config.old
mv /etc/ssh/sshd_config.d/* /etc/ssh/sshd_config.old
mv ./sshd_config /etc/ssh/sshd_config
mv ./sshd_banner /etc/ssh/sshd_banner


## change permissions of sshd config & ssh_banner
chown root:root /etc/ssh/sshd_config /etc/ssh/sshd_banner
chmod 644 /etc/ssh/sshd_config /etc/ssh/sshd_banner


## remove all prexisting ssh keys in home folders & /etc/
echo "\n\nRemoving all old keys"
for user in $(find . -maxdepth 1 -mindepth 1 -type d -printf '%f\n'); do
  rm /home/"$user"/.ssh/*
done
rm /root/.ssh/*


## open ports in iptables ( or other firewall service on system)
iptables -I INPUT -p tcp --dport 22288 -j ACCEPT
/etc/init.d/iptables restart
if [ ! -z $(command -v ufw) ]; then
  ufw allow 22288
  ufw enable
fi


# myDong = big
## enable then restart service
echo "\n\nFollowing lines are for restarting the service"
service ssh restart
service sshd restart
systemctl restart sshd.service
systemctl restart sshd


# extras
## create keys
## possibly start honeypot
## could add cool function to switch between fully open * ip / open to specific ip / key only


## ensure config isn't broken
echo "\n\nIf there is anything after this line, something is wrong with the sshd_config"
sshd -t
