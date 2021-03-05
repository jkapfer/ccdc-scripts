#!/bin/bash

##
# Devin Ingersoll
# 3/4/2021
# Used to set permission on all scripts and files
##

## check if current dir is cloned folder
CURDIR=$(pwd | awk -F/ '{print $(NF)}')
if [ "$CURDIR" != "ccdc-scripts" ];then
  echo "only use in repo's root dir"
  exit -1
fi
#also check that user is root
if [ "$EUID" -ne 0 ]
  then echo "RUN ONLY WITH SUDO"
  exit
fi


## set permissions on all *.sh scripts (root owned, only executable by root)
chown root:root *.sh
chmod 500 *.sh

## Set permissions on all files (sshd_config & sshd_banner)
chown root:root sshd_config sshd_banner
chmod 644 sshd_config sshd_banner
