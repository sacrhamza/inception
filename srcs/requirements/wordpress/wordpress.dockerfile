FROM debian:bookworm

# [INSTALL DEPS]
RUN apt update -y

RUN apt install -y  php-mysql
RUN apt install -y php-fpm

RUN apt install wget unzip -y

RUN wget  -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /usr/local/bin/wp
RUN mkdir -p /var/www/wordpress
RUN wp --allow-root core download --path=/var/www/wordpress

# listen on all interfaces on port 9000
RUN sed -i '/^listen = /c\listen = 0.0.0.0:9000' /etc/php/*/fpm/pool.d/www.conf

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY ./tools/service_healthy.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/service_healthy.sh

ENTRYPOINT ["entrypoint.sh"]
