### This project has been created as part of the 42 curriculum by <p color="#00ff00">hsacr</p>

#### Description:
    this project is about lerning docker and setup basic infrastructore using docker container
    in a network.

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
* Docker Network vs Host Network
* Docker Volumes vs Bind Mounts

### Instructions:
easily run:
```bash
make up
make down
```




# Inception
42 Inception

Resources:
ssl/tls:
0. [HTTPS, SSL, TLS & Certificate Authority Explained ](https://youtu.be/EnY6fSng3Ew?si=rQvRxGWTcMqd3OEt)
1. [what is ssl certificate](https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/)
2. [tls explained 7min](https://www.youtube.com/watch?v=67Kfsmy_frM)
3. [certificate from scratch](https://youtu.be/kAaIYRJoJkc?si=1MxIXaXMjvvCMlnR)
4. [tls vs ssl](https://aws.amazon.com/compare/the-difference-between-ssl-and-tls/)
5. [what is a database?](https://aws.amazon.com/what-is/database/)

nginx:
[configure https servers](https://nginx.org/en/docs/http/configuring_https_servers.html)

apache2/adminer:
[Apache Basics Tutorial](https://www.youtube.com/watch?v=1CDxpAzvLKY&t=303s)
[adminer]()
[docker vs virtual machine](https://aws.amazon.com/compare/the-difference-between-docker-vm/)
