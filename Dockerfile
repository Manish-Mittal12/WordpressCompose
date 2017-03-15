From manishmittal0788/wordpress
LABEL Maintainer="Manish Mittal" \
      Description="WordPress container with version 3 compose.yml for deploying over swarm"


ADD * /WordpressCompose

# wp-content volume
VOLUME /var/www/html
WORKDIR /var/www/html
RUN chown -R root.root /var/www/html


RUN mkdir -p /usr/src
ADD * /usr/src/
RUN chown -R nobody.nobody /usr/src/wordpress

# WP config
COPY wp-config.php /usr/src/wordpress
RUN chown nobody.nobody /usr/src/wordpress/wp-config.php && chmod 640 /usr/src/wordpress/wp-config.php


# Entrypoint to copy wp-content
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]


COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8001 80 3306 443

CMD ["apache2-foreground"]

# Modify permissions to allow plugin upload
RUN chown -R www-data:www-data /app/wp-content /var/www/html


# Expose environment variables
ENV DB_HOST **LinkMe**
ENV DB_PORT **LinkMe**
ENV DB_NAME wordpress
ENV DB_USER admin
ENV DB_PASS **ChangeMe**
ENV ROOT_PATH /

# Configure Wordpress to connect to local DB
ADD wp-config.php /app/wp-config.php

# Configure Wordpress to connect to local DB
COPY wp-config.php /app/wp-config.php

# Add scripts and make them executable.
COPY create_mysql_admin_user.sh /create_mysql_admin_user.sh
COPY create_db.sh /create_db.sh
COPY run.sh /run.sh
RUN chmod +x /*.sh

# Add volumes for MySQL and the application.
VOLUME ["/app/wp-content"]
VOLUME ["/var/lib/mysql", "/var/www/html"]

CMD ["/run.sh"]
