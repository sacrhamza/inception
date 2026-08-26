VOLUMES_DIR = /home/hsacr/data/

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

flcean: clean

re:
