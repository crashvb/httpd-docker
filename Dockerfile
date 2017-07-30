FROM crashvb/supervisord:202002211640
LABEL maintainer="Richard Davis <crashvb@gmail.com>"

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

# Configure: php7.0-fpm
RUN install --directory --group=www-data --mode=0755 --owner=www-data /var/run/php

# Configure: supervisor
ADD supervisord.apache2.conf /etc/supervisor/conf.d/apache2.conf
ADD supervisord.php.conf /etc/supervisor/conf.d/php.conf

# Configure: entrypoint
ADD entrypoint.httpd-cleanup /etc/entrypoint.d/httpd-cleanup

EXPOSE 80/tcp 443/tcp
