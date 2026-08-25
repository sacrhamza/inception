FROM debian:bookworm

# [INSTALL DEPS]
RUN apt update -y

RUN mkdir /wordpress/
ADD https://wordpress.org/latest.zip /wordpress
RUN apt install -y unzip
RUN unzip /wordpress/latest.zip 


RUN apt install -y  php-mysql
RUN apt install -y php-fpm

# [ REMOVE ME ]
RUN apt install -y file curl wget vim python3

# listen on all interfaces on port 9000
RUN sed -i '/^listen = /c\listen = 0.0.0.0:9000' /etc/php/*/fpm/pool.d/www.conf

# [php-fpm -F something and so on]
ENTRYPOINT ["php-fpm", "-F"]
