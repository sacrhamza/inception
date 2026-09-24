### This project has been created as part of the 42 curriculum by <p color="#00ff00">hsacr</p>

#### Description:
    this project is about lerning docker and setup basic infrastructore using docker containers / docker compose in a network.

project structure: 
```bash
tree *
├──  DEV_DOC.md
├──  dont_push_envs
├──  Makefile
├──  README.md
├──  secrets
│  ├──  database_secrets
│  └──  wordpress_secrets
├──  srcs
│  ├──  docker-compose.yml
│  ├──  Dockerfiles
│  │  └──  nginx
│  └──  requirements
│     ├──  mariadb
│     │  ├──  mariadb.dockerfile
│     │  └──  tools
│     │     ├──  entrypoint.sh
│     │     └──  service_healthy.sh
│     ├──  nginx
│     │  ├──  configs
│     │  │  └──  inception.conf
│     │  ├──  nginx.dockerfile
│     │  └──  tools
│     │     └──  entrypoint.sh
│     └──  wordpress
│        ├──  tools
│        │  ├──  entrypoint.sh
│        │  └──  service_healthy.sh
│        └──  wordpress.dockerfile
└──  USER_DOC.md
```

int this project i have a makefile that setup everything:
```bash
make
```

Docker

This project uses Docker to containerize each service and isolate the infrastructure into separate containers. Docker Compose is used to build and manage the containers, networks, and volumes. NGINX acts as the only entry point to the infrastructure, while WordPress/PHP-FPM and MariaDB run in separate containers. Docker volumes are used to persist WordPress and database data.

i have a docker compose in srcs that spin 3 containers:
=> nginx with tlsv2 or tlsv3 listening port 443 from the host;
=> wordpress/php-fpm; php fast cgi getting cgi request from nginx and return data; listen on port 9000; and also wordpress files, configured, it has two users one administrator and another normal user;
=> mariadb as a database connected to wordpress to store data via a user on port 3306; and puting data in /home/hsacr/data/database

* diff between virtual machine and docker:
- Docker and virtual machines (VMs) are two technologies used in application deployment. In the software development lifecycle, deployment prepares the application code to run for your end users. Docker is an open-source platform that developers use to package software into standardized units called containers. The container has both the application code and its environment, including libraries, system tools, and runtime. Using Docker, you can deploy and scale applications on any machine and ensure your code runs consistently. In contrast, a virtual machine is a digital copy of a physical machine. You can have multiple virtual machines with their own individual operating systems running on the same host operating system. Developers configure the virtual machine to create the application’s environment. It’s also possible to run Docker containers on virtual machines.

- VIRTUAL MACHINE:
As the name suggests, virtual machines (VMs) provide virtualization of an entire machine (server). A virtual machine emulates the hardware components of a physical machine, such as the CPU, memory, network interface card, USB controllers, and sound cards. You can run a guest operating system and multiple applications in the virtual environment.

- Docker:
A VM lets you run a virtual machine on any hardware. Docker lets you run an application on any operating system. It uses isolated user-space instances known as containers.
Docker containers have their own file system, dependency structure, processes, and network capabilities. The application has everything it requires inside the container and can run anywhere. Docker container technology uses the underlying host operating system kernel resources directly.

End product

Docker is the name of the open-source container platform that’s owned and operated by the company Docker. There are alternative platforms like Podman, although they’re far less popular; Docker is synonymous with containerization. The container is the artifact, the usable part for the end user.

A virtual machine itself is the usable part for the end user. The technology isn’t associated with a specific brand. You can deploy VMs in on-premises data centers or access them via APIs as a managed cloud service.

* Secrets vs Environment Variables

| Environment Variables                                                          | Secrets                                                                            |
| ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| Used mainly for configuration                                                  | Used mainly for sensitive information                                              |
| Values are commonly provided through `.env` or `environment`                   | Values are stored separately and mounted into the container                        |
| Can contain non-sensitive configuration such as `DOMAIN_NAME`                  | Should contain passwords, credentials, and other confidential data                 |
| Values can be visible through container configuration such as `docker inspect` | Designed to avoid putting sensitive values directly into the Compose configuration |
| Example: `DOMAIN_NAME=example.com`                                             | Example: `MARIADB_PASSWORD=...`                                                    |


* Docker Network vs Host Network
| Docker Network                                                      | Host Network                                                        |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Uses a Docker-managed network                                       | Uses the host machine's network directly                            |
| Containers have their own network interfaces/IPs                    | Container shares the host's network stack                           |
| Provides network isolation between containers and the host          | Provides little network isolation                                   |
| Containers can communicate using service names, e.g. `mariadb:3306` | Docker service-name DNS is not available in the usual way           |
| Ports can be mapped from container to host                          | No port mapping is required                                         |
| Example: `ports: - "443:443"`                                       | Container directly uses the host's ports                            |
| Multiple containers can use the same internal port                  | Port conflicts with host applications are possible                  |
| Better suited for containerized applications                        | Useful for applications requiring direct access to the host network |
| Recommended for the Inception project                               | Not recommended for the Inception project                           |
| Example: `nginx → wordpress → mariadb` through a Docker network     | Example: NGINX container directly using the host's network          |


* Docker Volumes vs Bind Mounts
| Docker Volume                                                                                 | Bind Mount                                                                 |
| --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| Managed by Docker                                                                             | Managed directly by the user                                               |
| Docker decides where the volume is stored by default                                          | User explicitly chooses the host directory                                 |
| Does not normally require a specific host path                                                | Requires a specific host path                                              |
| Example: `my_volume:/var/lib/mysql`                                                           | Example: `/home/hsacr/data/database:/var/lib/mysql`                        |
| Stored in Docker's storage area by default                                                    | Stored exactly at the specified host path                                  |
| Easier to manage with Docker                                                                  | Gives more control over the location                                       |
| Can be created with `docker volume create`                                                    | The host directory can be created directly with normal filesystem commands |
| Good for persistent container data                                                            | Good when you need the data in a specific host directory                   |
| Docker manages the volume lifecycle                                                           | User manages the host directory                                            |
| Can be inspected with `docker volume inspect`                                                 | Can be inspected directly with normal filesystem commands                  |
| Inception can use a volume configured with `driver_opts` to bind to a required host directory | Directly maps the required `/home/<login>/data/...` directory              |


### Instructions:
to start the project easily run:
```bash
make up
```
to stop it run:
```bash
make down
```
to stop and remove containers and get rid of docker network run:
```
make clean
```
to remove anything related to the project:
```
# NOTE: even data inside /home/hsacr/data/ will be removed + inception images
make fclean
```

### THE USE OF AI:
ai used to get good sources for services(docs, youtube vides and so on);


### Resources:
docker/docker compose:
[dockerfile](https://docs.docker.com/reference/dockerfile/)
[docker crush course](https://youtu.be/eGz9DS-aIeY?si=m82cL1jAm59g2MPC)
[learn docker!!](https://youtu.be/eGz9DS-aIeY?si=dDzrNnAV5ZfsWcsj)
[the only docker toturial you need to get started](https://youtu.be/DQdB7wFEygo?si=wCWmYU_NdO_m9rOR)
[docker compose](https://youtu.be/SXwC9fSwct8?si=sgfW4q1g7BVDhk7C)
[docker compose toturial](https://youtu.be/SXwC9fSwct8?si=sgfW4q1g7BVDhk7C)
[official docker compose doc](https://docs.docker.com/compose/)

ssl/tls:
[HTTPS, SSL, TLS & Certificate Authority Explained ](https://youtu.be/EnY6fSng3Ew?si=rQvRxGWTcMqd3OEt)
[what is ssl certificate](https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/)
[tls explained 7min](https://www.youtube.com/watch?v=67Kfsmy_frM)
[certificate from scratch](https://youtu.be/kAaIYRJoJkc?si=1MxIXaXMjvvCMlnR)
[tls vs ssl](https://aws.amazon.com/compare/the-difference-between-ssl-and-tls/)

nginx:
[configure https servers](https://nginx.org/en/docs/http/configuring_https_servers.html)
[how to setup ssl with nginx?](https://youtu.be/X3Pr5VATOyA?si=nIXWh3FrNkB9kD0t)
[nginx https servers](https://youtu.be/MVuJ5h2YQoQ?si=McinaS_hE2QosTx4)

sql/mariadb/databases:
[SQL tutorial](https://www.w3schools.com/sql/)
[install mariadb](https://mariadb.com/docs/server/mariadb-quickstart-guides/installing-mariadb-server-guide)
[learn mariadb](https://youtu.be/-b3trv4e5TE?si=jEmZy9J1oiuf-2di)
[what is a database? ibm](https://www.ibm.com/think/topics/database)
[what is database? aws](https://aws.amazon.com/what-is/database/)

wordpress/php-fmp:
[php-fpm](https://youtu.be/vohsuhwWvpw?si=OSP2x5UEQZyMkEmS)
[php and docker](https://youtu.be/njcUv0e8egM?si=d_zroSVXpXAJnrHv)
[wordpress cli](https://youtu.be/kSwcJmNFoac?si=re1jGGYDEk5JXwUp)
[official worpdress site](https://wordpress.com/)
[setup wordpress](https://developer.wordpress.org/advanced-administration/before-install/howto-install/)
[wp cli](https://youtu.be/L13YJ_VVbac?si=BFqwq7rog7wtHvAo)

