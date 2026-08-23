FROM debian

# [INSTALL DEPS]
RUN apt update -y
RUN apt install -y php
RUN mkdir /wordpress/
ADD https://wordpress.org/latest.zip /wordpress
RUN apt install -y unzip
RUN unzip /wordpress/latest.zip 
RUN apt install -y php-fpm

# [ REMOVE ME ]
RUN apt install -y file curl wget vim python3


# [php-fpm -F something and so on]
