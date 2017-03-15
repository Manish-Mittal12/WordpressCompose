#!/bin/bash

# terminate on errors
set -e

# Check if volume is empty
if [ ! "$(ls -A "/var/www/html" 2>/dev/null)" ]; then
    echo 'Setting up wordpress volume'
    # Copy wp-content from Wordpress src to volume
    cp -r /root/Test/wordpress /var/www/html
    chown -R nobody.nobody /var/www/html
  
fi

if [ ! "$(ls -A "/var/lib/mysql" 2>/dev/null)" ]; then
    echo 'Setting up mysql volume'
    # Copy wp-content from Wordpress src to volume
    cp -r /root/Test/SQL /var/lib/mysql
    chown -R nobody.nobody /var/lib/mysql
  
fi

exec "$@"
