#### USER DOC

This project uses Docker to containerize each service and isolate the infrastructure into separate containers. Docker Compose is used to build and manage the containers, networks, and volumes. NGINX acts as the only entry point to the infrastructure, while WordPress/PHP-FPM and MariaDB run in separate containers. Docker volumes are used to persist WordPress and database data.

i have a docker compose in srcs that spin 3 containers:
=> nginx with tlsv2 or tlsv3 listening port 443 from the host;
=> wordpress/php-fpm; php fast cgi getting cgi request from nginx and return data; listen on port 9000; and also wordpress files, configured, it has two users one administrator and another normal user;
=> mariadb as a database connected to wordpress to store data via a user on port 3306; and puting data in /home/hsacr/data/database

#### START & STOP THE PRJECT
- to start the prject you can run:
```bash
make up # or simply make
```
- and to stop it you can run:
```bash
make down # or make clean
```
- to clean everything you can run:
```bash
make fclean
```

#### ACCESS THE WEBSITE:
- you can access the website:
    <p style="color: greeen">https://hsacr.42.fr/</p>
- and for the the administration panel:
    <p style="color: greeen">https://hsacr.42.fr/wp-admin/</p>

#### PROJECT CREDENTIALS:
- credentials must be in secrets forlders, exactely two files:
    <p style="color: greeen">database_secrets</p>
    <p style="color: greeen">wordpress_secrets</p>
example of credentials that the project deponds on:

```
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
- plus the prject deponds on a file named .env in srcs where domain name is defined:
```bash
cat srcs/.env
DOMAIN_NAME=something.com # it points to your local ip
```

#### CHECK SERVICES:
* to check services are running correctely you can:
1. check py running:
```bash
docker compose -f src/docker-compose.yml ps # and you should see three running containers, two of them healthy
# mariadb healthy && wordpress healthy
```
2. check if you can access https://hsacr.42.fr/ and https://hsacr.42.fr/wp-admin

