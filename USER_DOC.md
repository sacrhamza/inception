#### USER DOC
basically the prject is about setup a small infrastructor,
services provided are:
* nginx webserver serving wordpress website.
* configured wordpress website.
* a database that wordpress can use.

#### START & STOP THE PRJECT
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
