FROM crashvb/supervisord:202302172130@sha256:c3ca0e25621af7c6bc594a0469d1ed763b4868f8fc5ceabaac384bd4c2496834
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:c3ca0e25621af7c6bc594a0469d1ed763b4868f8fc5ceabaac384bd4c2496834" \
	org.opencontainers.image.base.name="crashvb/supervisord:202302172130" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing httpd." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/httpd-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/httpd" \
	org.opencontainers.image.url="https://github.com/crashvb/httpd-docker"

# Install packages, download files ...
RUN APT_ALL_REPOS=1 docker-apt apache2 libapache2-mod-fcgid libapache2-mod-wsgi-py3 php-apcu php-cli php-fpm ruby

# Configure: httpd
RUN echo "Include vhost.d/" >> /etc/apache2/apache2.conf && \
	mkdir --parents /etc/apache2/vhost.d/ && \
	ln --symbolic /usr/lib/cgi-bin /var/www/cgi-bin && \
	a2enconf php8.1-fpm && \
	a2enmod actions cgid proxy_fcgi setenvif wsgi

# Configure: hello
COPY apache.hello /etc/apache2/vhost.d/hello
COPY erb.rb /usr/lib/cgi-bin/
COPY hello.* /var/www/hello/

# Configure: php-fpm
RUN install --directory --group=www-data --mode=0755 --owner=www-data /var/run/php

# Configure: supervisor
COPY supervisord.apache2.conf /etc/supervisor/conf.d/apache2.conf
COPY supervisord.php.conf /etc/supervisor/conf.d/php.conf

# Configure: entrypoint
COPY entrypoint.httpd-cleanup /etc/entrypoint.d/httpd-cleanup

# Configure: healthcheck
COPY healthcheck.apache2 /etc/healthcheck.d/apache2
COPY healthcheck.php /etc/healthcheck.d/php

EXPOSE 80/tcp 443/tcp
