FROM debian:bookworm

RUN apt update -y
RUN apt install -y vsftpd

# [FOR DEBUGIING]
RUN apt install -y curl ftp vim wget

COPY ./script.sh /bin/
RUN chmod +x /bin/script.sh

RUN cat << EOF > /etc/vsftp.conf
local_root=/tmp/
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30024
EOF

# ENTRYPOINT ["script.sh"]
