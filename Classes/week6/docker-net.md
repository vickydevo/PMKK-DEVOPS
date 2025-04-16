# Docker Networking Documentation

This documentation provides an overview of Docker networking, focusing on the default bridge network, user-defined networks, and macvlan networks. It includes use cases, steps to set up these networks, and commands to inspect and verify connectivity.

---

## 1. Bridge Network

The **bridge network** is the default network that containers are connected to if no specific network is specified during container creation. It allows containers on the same host to communicate with each other while remaining isolated from external networks.

### Use Case
- Ideal for communication between containers on the same Docker host.
- Provides isolation from external networks.

### Steps to Create and Use Bridge Network
1. **Create a custom bridge network (optional):**
    ```bash
    docker network create --driver bridge my-bridge-network
    ```
2. **Run containers and attach them to the bridge network:**
    ```bash
    docker run -d --name container1 --network my-bridge-network nginx
    docker run -d --name container2 --network my-bridge-network nginx
    ```
3. **Verify connectivity between containers:**
    ```bash
    docker exec -it container1 ping container2
    ```

### Notes
- Containers on the same bridge network can communicate using container names as hostnames.
- Communication is isolated from other bridge networks.

---

## 2. User-Defined Network

A **user-defined network** is a custom network created by the user to provide more control over container communication. Containers on the same user-defined network can communicate using container names as DNS hostnames.

### Use Case
- Useful for organizing containers into logical groups.
- Provides better control over container communication.

### Steps to Create and Use User-Defined Network
1. **Create a user-defined network:**
    ```bash
    docker network create asgard
    ```
2. **Run containers and attach them to the user-defined network:**
    ```bash
    docker run -itd --rm --network asgard --name loki busybox
    docker run -itd --rm --network asgard --name odin busybox
    ```
3. **Inspect the network:**
    ```bash
    docker network inspect asgard
    ```
4. **Verify connectivity between containers:**
    ```bash
    docker exec -it loki ping odin
    ```

### Notes
- User-defined networks provide automatic DNS resolution for container names.
- Containers on the same user-defined network can communicate directly.

---

## 3. Macvlan Network

The **macvlan network** allows containers to appear as physical devices on the network. Each container gets its own MAC address and IP address, making it directly accessible on the physical network.

### Use Case
- Suitable for scenarios where containers need to be directly accessible on the physical network.
- Useful for legacy applications that require direct network access.

### Steps to Create and Use Macvlan Network
1. **Create a macvlan network:**
    ```bash
    docker network create -d macvlan \
         --subnet=192.168.1.0/24 \
         --gateway=192.168.1.1 \
         -o parent=eth0 my-macvlan-network
    ```
2. **Run containers and attach them to the macvlan network:**
    ```bash
    docker run -itd --rm --network my-macvlan-network --name thor busybox
    docker run -itd --rm --network my-macvlan-network --name mjolnir busybox
    ```
3. **Verify connectivity between containers and the external network:**
    ```bash
    docker exec -it thor ping 192.168.1.1
    docker exec -it thor ping mjolnir
    ```

### Notes
- Containers on a macvlan network are directly accessible on the physical network.
- The parent interface (e.g., `eth0`) must support promiscuous mode.

---

## Commands for Network Inspection and Debugging

1. **List all Docker networks:**
    ```bash
    docker network ls
    ```
2. **Inspect a specific network:**
    ```bash
    docker network inspect <network-name>
    ```
3. **View bridge network interfaces:**
    ```bash
    bridge link
    ```
4. **Inspect container network interfaces:**
    ```bash
    docker exec -it <container-name> ip addr
    ```

---

Each of these networking types serves different purposes depending on your container deployment needs. Use bridge networks for isolated communication on a single host, user-defined networks for logical grouping, and macvlan networks for direct access to the physical network.