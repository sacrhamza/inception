FROM debian:bookworm

ARG INSTALL='apt install -y'

RUN apt update -y
RUN $INSTALL  mariadb-server mariadb-client galera-4

# [REMOVE ME] ESSETIONAL 
RUN  $INSTALL vim curl file wget
RUN sed -i '/^bind/c\bind = 0.0.0.0'  /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# to check service_healthy
COPY ./tools/service_healthy.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/service_healthy.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
