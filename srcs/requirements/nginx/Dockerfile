FROM debian

RUN apt update -y
RUN apt -y install nginx

# this just for testing puposes delete that line in production
RUN apt -y install vim bash curl wget curl  file

WORKDIR /etc/nginx

# COPY config/nginx.conf .


# you should create a private key
# create a certificate
# create root ca key
# create a root certificate
# sign the server certificate using root ca key and root ca certificate

# [REMOVEME PRODUCTION]
COPY ./alias.sh /tmp/
RUN cat /tmp/alias.sh >> /root/.bashrc
