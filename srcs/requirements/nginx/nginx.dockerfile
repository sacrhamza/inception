FROM debian

RUN apt update -y
RUN apt -y install nginx openssl

# this just for testing puposes delete that line in production
RUN apt -y install vim bash curl wget curl  file

WORKDIR /etc/nginx

LABEL org.opencontainers.image.authors="Hamza Sacr, <hsacr@student.1337.ma>"

# COPY config/nginx.conf .


# you should create a private key
# create a certificate
# create root ca key
# create a root certificate
# sign the server certificate using root ca key and root ca certificate

# SETUP SELF SIGNED CERTIFICATE
RUN mkdir /etc/nginx/ssl
RUN mkdir ssl/certs &&  mkdir ssl/private
# I CAN ALSO CREATE A CA ROOT AND USE TO SIGN MY CERTIFICATE ACTUALLY, I WOULD DO THAT
RUN openssl genrsa -out ssl/private/server.key 2048
RUN openssl req -x509 -key ssl/private/server.key -out ssl/certs/certificate.pem -subj '/C=US/ST=ls/L=hey/O=hey/CN=localhost'


# SETUP CONFIG
COPY ./configs/inception.conf ./conf.d
RUN rm -rf sites-enabled/default


# [REMOVEME PRODUCTION]
COPY ./alias.sh /tmp/
RUN cat /tmp/alias.sh >> /root/.bashrc
RUN echo 'it works, yuy yuy!!!' > /tmp/index.html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
