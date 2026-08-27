VOLUMES_DIR = /home/hsacr/data/

all: up

mariadb:
	docker compose -f ./srcs/docker-compose.yml up --build  mariadb

wordpress:
	docker compose -f ./srcs/docker-compose.yml up --build  wordpress 

up:
	sudo mkdir -p ${VOLUMES_DIR}/wordpress
	sudo mkdir -p ${VOLUMES_DIR}/database
	docker compose -f ./srcs/docker-compose.yml up --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down

fclean: clean
	docker rmi $(docker image ls --filter "reference=*:inception" -q) || true
	sudo rm -rf ${VOLUMES_DIR}/*

re: fclean up
