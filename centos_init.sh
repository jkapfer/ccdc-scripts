#! /bin/bash
## Taken from (https://www.vultr.com/docs/how-to-install-prestashop-on-centos-7)

sudo yum clean all
# sudo yum -y update

# Update httpd
sudo yum update httpd

# Get rid of apache landing page
sudo sed -i 's/^/#&/g' /etc/httpd/conf.d/welcome.conf
# Remove apache displaying directories in root directory
sudo sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/httpd/conf/httpd.conf

# Restart httpd service
sudo systemctl restart httpd.service

# Update
sudo yum update mariadb mariadb-server

# securely install mariadb and follow installation
sudo /usr/bin/mysql_secure_installation

# Restart Maria DB
sudo systemctl start mariadb.service