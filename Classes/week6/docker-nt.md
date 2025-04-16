# Docker Networking

Docker networking allows containers to communicate with each other, the host machine, and external networks. Docker provides several network drivers to manage container networking.

### Types of Docker Networks

1. **Bridge Network** (Default)
    - Used for standalone containers.
    - Containers on the same bridge network can communicate with each other.
    - Example:
      ```bash
      docker network create my_bridge
      docker run --network my_bridge --name container1 alpine
      docker run --network my_bridge --name container2 alpine
      ```

2. **User-Defined Bridge Network**
    - A custom network created by the user, based on the bridge network driver but with more control and flexibility.
    - Containers on the same user-defined bridge network can communicate with each other using container names as DNS.
    - Allows configuration of network-specific options like subnets and IP ranges.
    - Example:
      ```bash
      docker network create my_custom_bridge
      docker run --network my_custom_bridge --name app1 alpine
      docker run --network my_custom_bridge --name app2 alpine
      ```
      In this example, `app1` and `app2` can communicate with each other using their container names.

3. **Host Network**
    - Shares the host's network stack.
    - No isolation between the container and the host.
    - Example:
      ```bash
      docker run --network host nginx
      ```

4. **None Network**
    - No network connectivity.
    - Used for security or custom networking.
    - Example:
      ```bash
      docker run --network none alpine
      ```

5. **Overlay Network**
    - Used for multi-host communication in Docker Swarm.
    - Example:
      ```bash
      docker network create -d overlay my_overlay
      docker service create --network my_overlay nginx
      ```

6. **Macvlan Network**
    - Assigns a MAC address to the container for direct communication.
    - Example:
      ```bash
      docker network create -d macvlan \
         --subnet=192.168.1.0/24 \
         --gateway=192.168.1.1 \
         -o parent=eth0 my_macvlan
      docker run --network my_macvlan alpine
      ```


## Inspecting Networks
To view details of a network:
```bash
docker network inspect <network_name>
```

## Listing Networks
To list all networks:
```bash
docker network ls
```
![Image](https://github.com/user-attachments/assets/d4b39b9e-90b6-453c-996c-339809cd8884)
Docker networking is essential for containerized applications to communicate effectively.