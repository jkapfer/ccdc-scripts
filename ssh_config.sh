#!/bin/sh

##
# Devin Ingersoll
# 3/2/2021
##

## make sure ssh is installed
if [ ! -z $(command -v apt) ]; then sudo apt install openssh-server; fi
if [ ! -z $(command -v dnf) ]; then sudo dnf install openssh-server; fi
if [ ! -z $(command -v yum) ]; then sudo yum install openssh-server; fi
if [ ! -z $(command -v pacman) ]; then sudo pacman -S install openssh-server; fi

## backup old sshd config 


## copy over new sshd config  


## copy over /etc/ssh/ssh_banner


## change permissions of sshd config & ssh_banner


## remove all prexisting ssh keys in home folders & /etc/ 
## (optional) create keys


## open ports in iptables ( or other firewall service on system) 


## enable then restart service 


## possibly start honeypot 


## could add cool function to switch between fully open * ip / open to specific ip / key only 
