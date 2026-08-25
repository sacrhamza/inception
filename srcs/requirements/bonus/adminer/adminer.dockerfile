FROM debian:bookworm

RUN apt update -y
RUN apt install adminer -y

RUN apt install -y vim curl wget


RUN ln -s /etc/apache2/conf-available/adminer.conf /etc/apache2/conf-enabled/adminer.conf
RUN a2enmod ssl
RUN a2ensite default-ssl.conf
RUN a2dissite 000-default.conf

ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
