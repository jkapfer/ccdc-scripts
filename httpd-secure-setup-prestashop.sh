#! /bin/bash
#mod_ssl provides support to Apache for ssl encryption
echo "Setting up SSL for Apache server..."
sudo yum -y install mod_ssl
#making directory to store private key, the /etc/ssl/certs is already available for holding the cert
sudo mkdir /etc/ssl/private
#changing permissions so only the root user has access
sudo chmod 700 /etc/ssl/private
#creating ssl key and certificate files with openssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
#you will need to fill out the prompts for the cert
#the only fields you really need to fill out are the country code and Common Name
#the common name is required and you can just use the server ip if there is no domain name
#the rest can just be filled with "." to leave the fields blank
#################################################################################
#adding Diffie-Hellman group for negotiating Perfect Forward Secrecy with clients
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
#appending Diffie-Hellman group to the end of the self-signed cert
cat /etc/ssl/certs/dhparam.pem | sudo tee -a /etc/ssl/certs/apache-selfsigned.crt
#################################################################################
#now you need to set up the conf file
#you can use whatever text editor you want but vi is the script default
#sudo vi /etc/httpd/conf.d/ssl.conf
sudo nano /etc/httpd/conf.d/ssl.conf
#you need to find the lines "SSLCertificateFile" and "SSLCertificateKeyFile" and
#point them to the files we created earlier
#the crt is at /etc/ssl/certs/apache-selfsigned.crt
#the key is at /etc/ssl/private/apache-selfsigned.key
################################################################################
#check the configfile for errors
sudo apachectl configtest
#if it says Syntax OK then everything worked correctly
#now it is time to restart the server to apply the settings
sudo systemctl restart httpd
#now you need to open the ports if they are not already
echo "done"
