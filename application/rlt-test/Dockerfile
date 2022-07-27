FROM php:7.4.3-apache
COPY source/ /var/www/html/
RUN sed -i "s/Listen 80/Listen 8080/" /etc/apache2/ports.conf
