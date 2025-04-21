# Docker Compose Overview

Docker Compose is a tool for defining and running multi-container applications. It simplifies the management of your application stack by using a single YAML configuration file to define services, networks, and volumes. With a single command, you can create and start all the services defined in the configuration file.

## Key Features
- Works in all environments: production, staging, development, testing, and CI workflows.
- Simplifies the lifecycle management of applications.
- Supports service orchestration, networking, and volume management.

---

## Setting Up Docker Compose on Ubuntu

1. Install Docker Compose:
    ```bash
    sudo apt install docker-compose -y
    ```

2. Alternatively, download and install a specific version:
    ```bash
    curl -SL https://github.com/docker/compose/releases/download/v2.35.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ```

---

## Writing a `docker-compose.yml` File

### Example 1: Basic Nginx Service
```yaml
version: '3'
services:
  nginx:
     image: nginx
     ports:
        - "8081:80"
     restart: always
```

### Example 2: Multiple Nginx Services with Volumes
```yaml
version: '3'
services:
  nginx1:
     image: nginx
     ports:
        - "8081:80"
     restart: always
     volumes:
        - ./html:/usr/share/nginx/html
  nginx2:
     image: nginx
     ports:
        - "8082:80"
     restart: always
     volumes:
        - Nginx_VolData:/usr/share/nginx/html

volumes:
  Nginx_VolData:
```

### Example 3: Nginx with Custom Network and IP
```yaml
version: '3'
services:
  my_nginx:
     image: nginx:latest
     ports:
        - "8081:80"
     restart: always
     volumes:
        - my_volume:/usr/share/nginx/html
     networks:
        my_network:
          ipv4_address: '10.0.0.5'
  up_nginx:
     image: nginx:latest
     ports:
        - "8082:80"
     restart: always
     volumes:
        - ./html:/usr/share/nginx/html
     networks:
        my_network:
          ipv4_address: '10.0.0.2'

networks:
  my_network:
     driver: bridge
     ipam:
        config:
          - subnet: 10.0.0.0/24

volumes:
  my_volume:
```

---

## Example: WordPress with MySQL

```yaml
version: '3'
services:
  wordpress_front:
     image: wordpress
     ports:
        - "8089:80"
     depends_on:
        - mysql
     environment:
        WORDPRESS_DB_HOST: mysql
        WORDPRESS_DB_USER: root
        WORDPRESS_DB_NAME: wordpress_mysql
        WORDPRESS_DB_PASSWORD: "admin_1234"
     networks:
        mysql_nt:
          ipv4_address: "10.0.0.55"
  mysql:
     image: "mysql:5.7"
     environment:
        MYSQL_DATABASE: wordpress_mysql
        MYSQL_ROOT_PASSWORD: "admin_1234"
     volumes:
        - ./mysql:/var/lib/mysql
     networks:
        mysql_nt:
          ipv4_address: "10.0.0.45"

networks:
  mysql_nt:
     ipam:
        driver: default
        config:
          - subnet: "10.0.0.0/24"
```

---

## Running the Compose File

1. Start the services:
    ```bash
    docker-compose up -d
    ```

2. Verify running containers:
    ```bash
    sudo docker ps
    ```

3. Stop and remove containers:
    ```bash
    sudo docker-compose down
    ```

---

## Notes
- Use `restart: always` to ensure containers restart automatically.
- Use bind mounts (`./html:/usr/share/nginx/html`) or named volumes (`my_volume:/usr/share/nginx/html`) for persistent data.
- Define custom networks and IP addresses for better control over container communication.
