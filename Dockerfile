FROM php:7.2-apache

RUN apt-get update
RUN apt-get install -y libpng-dev libcurl4-openssl-dev libxml2-dev libldap-dev ssl-cert

# enable php extenstions
RUN docker-php-ext-install gd curl xml xmlrpc mysqli intl ldap mbstring zip pdo_mysql sockets

# create virtual hosts
COPY conf/rogo.conf /etc/apache2/sites-available/rogo.conf

# enable apache mods
RUN a2enmod rewrite
RUN a2enmod ssl

# set Apache virtual hosts
RUN a2dissite 000-default
RUN a2ensite rogo
RUN rm -rf /var/www/html

# rogo php settings
COPY conf/rogo.ini /etc/php/7.2/apache2/conf.d/20-user.ini

# restart apache
RUN service apache2 restart

# create data dir
RUN mkdir /rogodata
RUN chown -R www-data:www-data /rogodata