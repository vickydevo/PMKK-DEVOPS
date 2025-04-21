# Docker First Practice Class

## 1. Installing Docker
### **For Ubuntu**
```bash
sudo apt update && sudo apt install -y git docker.io
```

### **Verify Docker Installation**
```bash
sudo docker -v  # Check Docker version
```

### **Check Available Docker Images**
```bash
sudo docker images
```

### **Add User to Docker Group (Optional, for Non-root Users)**
```bash
sudo usermod -aG docker $USER && newgrp docker
```

---
## 2. Running Basic Docker Containers
### **Run an Apache (httpd) Container in Interactive Mode**
```bash
docker run -it httpd
```
#### **Expected Output**
- Apache server starts but may show a warning:
  ```
  AH00558: httpd: Could not reliably determine the server's fully qualified domain name...
  ```
- Press **Ctrl+C** to stop the container.

---
## 3. Running Containers in Detached Mode
### **Run Apache in the Background (Detached Mode)**
```bash
docker run -d httpd
```

### **Run Apache and Expose Port 80 to the Host**
```bash
docker run -d -p 80:80 httpd
```

### **Run Ubuntu-based Apache Server on Port 81**
```bash
docker run -d -p 81:80 ubuntu/apache2
```

### **Run an Nginx Server on Port 90**
```bash
docker run -d -p 90:80 nginx
```

---
## 4. Managing Running Containers
### **List Running Containers**
```bash
docker ps
```

### **List All Containers (Including Stopped Containers)**
```bash
docker ps -a
```

### **Restart a Container**
```bash
docker restart <container_id>
```

### **Enter a Running Container (Bash Shell)**
```bash
docker exec -it <container_id> bash
```

### **Stop a Running Container**
```bash
docker stop <container_id>
```

### **Remove a Stopped Container**
```bash
docker rm <container_id>
```

---
## 5. Accessing and Editing Files Inside a Container
### **Enter an Nginx Container**
```bash
docker exec -it <container_id> /bin/bash
```

### **Modify the Default Web Page**
If text editors like `nano` or `vi` are missing, install them:
```bash
apt update && apt install -y nano vim
```
Then edit the index file:
```bash
nano /usr/share/nginx/html/index.html
```
Alternatively, use `echo`:
```bash
echo "Hello, Docker!" > /usr/share/nginx/html/index.html
```

---
## 6. Checking Container Logs
### **View Logs of a Specific Container**
```bash
docker logs <container_id>
```

### **Follow Live Logs**
```bash
docker logs -f <container_id>
```

---
## 7. Exiting and Cleaning Up
### **Exit a Running Container**
- Type `exit` or press `Ctrl+D` inside the container.

### **Stop and Remove All Containers**
```bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```

### **Remove All Docker Images (Caution: Deletes Everything!)**
```bash
docker rmi $(docker images -q)
```

---
## 8. Additional Resources
- [Docker Documentation](https://docs.docker.com/)
- [Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)

---
## 9. Summary of Commands
| Command | Description |
|---------|-------------|
| `docker -v` | Check Docker version |
| `docker images` | List available Docker images |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker run -it httpd` | Run Apache in interactive mode |
| `docker run -d httpd` | Run Apache in detached mode |
| `docker exec -it <container_id> bash` | Enter a running container |
| `docker logs <container_id>` | View container logs |
| `docker stop <container_id>` | Stop a running container |
| `docker rm <container_id>` | Remove a stopped container |
| `docker rmi <image_id>` | Remove a Docker image |

---
This guide should help you structure your **first Docker practice session** effectively! 🚀
