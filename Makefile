VOLUMES_DIR = /home/hsacr/data/

mariadb:
	docker compose -f ./srcs/docker-compose.yml up --build  mariadb


wordpress:
	docker compose -f ./srcs/docker-compose.yml up --build  wordpress 

up:
	docker compose -f ./srcs/docker-compose.yml up --build  nginx

down:
	docker compose down -f ./srcs/docker-compose.yml


clean:

flcean:



