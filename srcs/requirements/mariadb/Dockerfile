FROM debian

ARG INSTALL='apt install -y'


RUN apt update -y
RUN $INSTALL  mariadb-server mariadb-client galera-4

# just for me
RUN  $INSTALL vim curl 
