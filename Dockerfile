From manishmittal0788/wordpress
LABEL Maintainer="Manish Mittal" \
      Description="WordPress container with version 3 compose.yml for deploying over swarm"

# Expose environment variables
ENV DB_HOST wp-mysql
ENV DB_PORT 3306
ENV DB_NAME wordpress
ENV DB_USER root
ENV DB_PASS wordpress
ENV ROOT_PATH /

# wp-content volume
VOLUME /var/www/html
WORKDIR /var/www/html
RUN chown -R root.root /var/www/html


RUN mkdir -p /usr/src
ADD * /usr/src/
RUN chown -R root.root /usr/src/wordpress

# Configure Wordpress to connect to local DB
ADD wp-config.php /app/wp-config.php

# WP config
COPY wp-config.php /usr/src/wordpress
RUN chown root.root /usr/src/wordpress/wp-config.php && chmod 640 /usr/src/wordpress/wp-config.php

# Add scripts and make them executable.
COPY create_mysql_admin_user.sh /create_mysql_admin_user.sh
COPY create_db.sh /create_db.sh
COPY run.sh /run.sh
RUN chmod +x /*.sh

# Add volumes for MySQL and the application.
VOLUME ["/app/wp-content"]
VOLUME ["/var/lib/mysql", "/var/www/html"]

# Entrypoint to copy wp-content
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]

EXPOSE 8001 80 3306 443

#CMD ["/run.sh"]
CMD ["Docker stack deploy --compose-file docker-compose.yml wordpress"]
