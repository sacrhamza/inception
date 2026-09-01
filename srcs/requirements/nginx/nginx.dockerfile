FROM debian:bookworm

RUN apt update -y
RUN apt -y install nginx openssl

# this just for testing puposes delete that line in production
# RUN apt -y install vim bash curl wget curl  file

WORKDIR /etc/nginx

LABEL org.opencontainers.image.authors="Hamza Sacr, <hsacr@student.1337.ma>"

# SETUP SELF SIGNED CERTIFICATE
RUN mkdir /etc/nginx/ssl
RUN mkdir ssl/certs &&  mkdir ssl/private
RUN openssl genrsa -out ssl/private/server.key 2048

# SETUP CONFIG
COPY ./configs/inception.conf ./conf.d
RUN rm -rf sites-enabled/default

COPY ./tools/entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["entrypoint.sh"]
