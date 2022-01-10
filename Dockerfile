FROM crashvb/supervisord:202201080446@sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226" \
	org.opencontainers.image.base.name="crashvb/supervisord:202201080446" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing httpd." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/httpd-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/httpd" \
	org.opencontainers.image.url="https://github.com/crashvb/httpd-docker"

# Install packages, download files ...
RUN APT_ALL_REPOS=1 docker-apt apache2 libapache2-mod-fcgid libapache2-mod-wsgi php-apcu php-cli php-fpm ruby

# Configure: httpd
RUN echo "Include vhost.d/" >> /etc/apache2/apache2.conf && \
	mkdir --parents /etc/apache2/vhost.d/ && \
	ln --symbolic /usr/lib/cgi-bin /var/www/cgi-bin && \
	a2enconf php7.2-fpm && \
	a2enmod actions cgid proxy_fcgi setenvif wsgi

# Configure: hello
ADD apache.hello /etc/apache2/vhost.d/hello
ADD erb.rb /usr/lib/cgi-bin/
ADD hello.* /var/www/hello/

# Configure: php-fpm
RUN install --directory --group=www-data --mode=0755 --owner=www-data /var/run/php

# Configure: supervisor
ADD supervisord.apache2.conf /etc/supervisor/conf.d/apache2.conf
ADD supervisord.php.conf /etc/supervisor/conf.d/php.conf

# Configure: entrypoint
ADD entrypoint.httpd-cleanup /etc/entrypoint.d/httpd-cleanup

EXPOSE 80/tcp 443/tcp
