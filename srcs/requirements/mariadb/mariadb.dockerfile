FROM debian

ARG INSTALL='apt install -y'


RUN apt update -y
RUN $INSTALL  mariadb-server mariadb-client galera-4

# [REMOVE ME] ESSETIONAL 
RUN  $INSTALL vim curl file wget
RUN sed -i '/^bind/c\bind = 0.0.0.0'  /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh

COPY ./tools/file.sh /tmp/file.sh
COPY ./tools/service_healthy.sh /bin/
RUN chmod +x /bin/service_healthy.sh

ENTRYPOINT ["entrypoint.sh"]
