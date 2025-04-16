# Docker Networking Documentation

This documentation provides an overview of Docker networking, focusing on the default bridge network, user-defined networks, and macvlan networks. It includes use cases, steps to set up these networks, and commands to inspect and verify connectivity.

---
## Prerequisite: Check Network IP Address

Before working with Docker networks, it is essential to check the IP address of your host machine's network interfaces. This ensures that you configure Docker networks correctly and avoid IP conflicts.

### Steps to Check Network IP Address
1. **Use the `ip addr` command to list all network interfaces and their IP addresses:**
    ```bash
    ip addr
    ```
    ![Image](https://github.com/user-attachments/assets/ef92a506-359e-4441-8189-933caeeb0e51)

2. **Identify the interface you want to use for Docker networking (e.g., `eth0` or `wlan0`).**
3. **Note the subnet and gateway information for the selected interface.**

### Example Output
```bash
3: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    inet 192.168.1.100/24 brd 192.168.1.255 scope global dynamic eth0
       valid_lft 86392sec preferred_lft 86392sec
```

In this example:
- The IP address is `192.168.1.100`.
- The subnet is `192.168.1.0/24`.
- The gateway is typically `192.168.1.1`.

### Notes
- Ensure that the subnet used for Docker networks does not overlap with the host's existing network.
- Use this information when creating custom networks like macvlan to avoid conflicts.
- If unsure, consult your network administrator for guidance.
## 1. Bridge Network

The **bridge network** is the default network that containers are connected to if no specific network is specified during container creation. It allows containers on the same host to communicate with each other while remaining isolated from external networks.

### Use Case
- Ideal for communication between containers on the same Docker host.
- Provides isolation from external networks.

### Example: Using the Default Bridge Network

To create a container using the default bridge network, run the following command:

```bash
sudo docker run -dit --rm --name thor-cont busybox
sudo docker run -dit --rm --name mjolnir-cont busybox
sudo docker run -dit --rm --name stormbreaker nginx

```
![Image](https://github.com/user-attachments/assets/39283c99-a7b2-4d82-9e83-548a4bd3d3fe)

This starts a container named `thor-cont` using the default bridge network. You can verify its network settings with:

```bash
docker exec -it thor-cont ip addr
```

### Notes
- The default bridge network is automatically created by Docker and does not require manual setup.
- Containers on the default bridge network can communicate with each other only if you explicitly link them or configure port forwarding.
- Use this network for simple setups or testing purposes.

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