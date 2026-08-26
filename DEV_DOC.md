### DEV DOC

#### SETUP ENVIRONMENT FROM SCRATCH

* prerequisites:
at first you need docker engine and you can install it with:
[debain](https://docs.docker.com/engine/install/debian/)
[redhat](https://docs.docker.com/engine/install/rhel/)

* secrets:
two main files where credentials are stored as shell envs:
    => for example: 
```bash
$ cat secrets/database_secrets 
DATABASE_NAME="mydatabase"
MARIADB_USER="soeone"
MARIADB_USER_PASSWORD="someone's password"

$ cat secrets/wordpress_secrets 
WP_ADMIN_USER="superuser"
WP_ADMIN_PASSWORD="admin_password"
WP_ADMIN_EMAIL="someone@example.com"
WP_TITLE="title"
```
plus a file named .env in srcs where domain name is defined:
```bash
cat srcs/.env
DOMAIN_NAME=something.com # it points to your local ip
```

* configs:
- take a look at docker-compose.yml to understand the structure very well:
=> nginx main config is in : srcs/requirements/nginx/configs/inception.conf
which you can find it in container: /etc/nginx/conf.d/inception.conf
=> mariadb: i mainly create a database using envs in secret file secrets/database_secrets with just one user, check script srcs/requirements/mariadb/tools/entrypoint.sh, however you can configure mariadb editing /etc/mysql/
=> the same thing for wordpress, there is an entrypoint that setup wordpress and run php-fpm, all wordpress files would be found in /var/www/wordpress in container,
and /home/login/data/wordpress => /home/hsacr/data/wordpress

#### BUILD AND LAUNCH THE PROJECT:
- to start the prject you can run:
```bash
make up
```
- and to stop it you can run:
```bash
make down
```
- to clean everything you can run:
```bash
make fclean
```

- or just run:
```bash
# start
docker compose up --build -d

# stop:
docker compose down
```

#### RELEVANT COMMANDS TO MANAGE CONTAINERS AND VOLUMES:
* to see state and info about the containers:
```
# running containers
docker ps

# all containers (stopped and runnning)
docker ps -a

# or for compose
docker compose ps
docker compose ps -a

# to see all info about the container run:
docker inspect ${container_id}
```

* to attach to a running container: like mariadb
```
docker compose exec -it mariadb bash
container$ change something

# or run a command
docker compose exec mariadb mariadb --version
```

* to stop a running container run:
```
docker compose stop name
```

* to list docker volumes:
```bash
docker volume ls

# info about the volume
docker volume inspect volume
```


#### IDENTIFY THE PROJECT DATA:
the data for my database 'mariadb' and for wordpress
would be in /home/hsacr/data/database/, /home/hsacr/data/wordpress/ respectively

NOTE: Containers themselves are temporary. If you remove the MariaDB container, the files inside its writable layer disappear.

So i mount Docker volumes:
```docker compose
services:
 mariadb:
  volumes:
    - database_volume:/var/lib/mysql
 wordpress:
  volumes:
    - wordpress_volume:/var/www/wordpress

volumes:
  wordpress_volume:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/hsacr/data/wordpress
  database_volume:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/hsacr/data/database/
```
The containers are temporary, while the persistent project data is stored
on the host. Docker volumes are used to mount these host directories into
the containers:

```bash
MariaDB:
    host:      /home/hsacr/data/database
    container: /var/lib/mysql

WordPress:
    host:      /home/hsacr/data/wordpress
    container: /var/www/wordpress
```

Therefore, removing and recreating the containers does not remove the
project data, because the data is stored outside the containers on the host.
