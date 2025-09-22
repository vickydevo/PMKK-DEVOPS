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

```compose.yml
version: '3'
services:
  nginx:
    image: nginx
    ports:
      - "8081:80"
    restart: always #Ensure that the container restarts automatically if it stops.
```

## Running the Compose File

1. Start the services:
    ```bash
    docker-compose up -d
         or
    docker-compose -f nginx.yml up -d
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

## Types of Volumes in Docker

Docker supports three main types of volumes for managing persistent data:

### 1. Named Volumes
- Managed by Docker.
- Useful for sharing data between containers and persisting data beyond container lifecycle.

**CLI Example:**
```bash
docker volume create mydata
docker run -v mydata:/data nginx
```

**Compose Example:**
```yaml
services:
   nginx:
      image: nginx
      volumes:
         - mydata:/usr/share/nginx/html
volumes:
   mydata:
```

---

### 2. Bind Mounts
- Maps a directory or file from the host to the container.
- Useful for development and testing.

**CLI Example:**
```bash
docker run -v /path/on/host:/usr/share/nginx/html nginx
```

**Compose Example:**
```yaml
services:
   nginx:
      image: nginx
      volumes:
         - ./html:/usr/share/nginx/html
```

---

### 3. tmpfs Mounts
- Stores data in memory only (not persisted).
- Useful for sensitive or temporary data.

**CLI Example:**
```bash
docker run --tmpfs /tmp nginx
```

**Compose Example:**
```yaml
services:
   nginx:
      image: nginx
      volumes:
         - type: tmpfs
            target: /tmp
```




## Notes
- Use `restart: always` to ensure containers restart automatically.
- Use bind mounts (`./html:/usr/share/nginx/html`) or named volumes (`my_volume:/usr/share/nginx/html`) for persistent data.
- Define custom networks and IP addresses for better control over container communication.
