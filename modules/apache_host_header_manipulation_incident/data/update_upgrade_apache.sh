

#!/bin/bash



# Update the package list

sudo apt-get update



# Install the latest updates for all packages, including Apache

sudo apt-get upgrade apache2



# Restart the Apache service to apply the updates

sudo service apache2 restart