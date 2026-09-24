VOLUMES_DIR = /home/hsacr/data

all: up

mariadb:
	docker compose -f ./srcs/docker-compose.yml up --build  mariadb

wordpress:
	docker compose -f ./srcs/docker-compose.yml up --build  wordpress 

up:
	mkdir -p ${VOLUMES_DIR}/wordpress
	mkdir -p ${VOLUMES_DIR}/database
	docker compose -f ./srcs/docker-compose.yml up --build

detach:
	mkdir -p ${VOLUMES_DIR}/wordpress
	mkdir -p ${VOLUMES_DIR}/database
	docker compose -f ./srcs/docker-compose.yml up --build -d


down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	images=$$(docker image ls --filter "reference=*:inception" -q); docker rmi $$images

fclean: clean
	sudo rm -rf ${VOLUMES_DIR}/*
	docker volume rm srcs_wordpress_volume srcs_database_volume

re: fclean up

logs:
	docker compose -f ./srcs/docker-compose.yml logs
