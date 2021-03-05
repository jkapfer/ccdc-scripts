#! /bin/bash

## General housekeeping shanagans

# Check /etc/sudoers

# Remove access to crons from every user except root
awk -F: '{ print $1 }' /etc/passwd | tail -n+2 >> /etc/cron.deny


# Clear auth keys for root user
if [ -f "/root/.ssh/authorized_keys" ];
    : > /root/.ssh/authorized_keys
fi

# Clear auth keys for all users
for user_d in /home/* ; do
    if [ -d "$user_d/.ssh" ]; then   
        if [ -d "$user_d/.ssh/authorized_keys" ];
            : > "$user_d/.ssh/authorized_keys"
        fi
    fi 
done

# Check /etc/ssh/sshd_config

# Restart ssh
/etc/init.d/sshd restart


