

#!/bin/bash



# Declare variables

APACHE_CONF=${PATH_TO_APACHE_CONFIG_FILE}



# Backup the original Apache configuration file

cp $APACHE_CONF $APACHE_CONF.bak



# Enable strict validation of the Host header

sed -i 's/^#HostHeaderChecking\s\+Off/HostHeaderChecking On/' $APACHE_CONF



# Restart the Apache web server

systemctl restart apache2