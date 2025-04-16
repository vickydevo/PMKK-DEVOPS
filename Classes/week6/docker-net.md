# Docker Networking Documentation

This documentation provides an overview of Docker networking, focusing on the default bridge network, user-defined networks, and macvlan networks. It includes use cases, steps to set up these networks, and commands to inspect and verify connectivity.

---
## Prerequisite: Check Network IP Address

Before working with Docker networks, it is essential to check the IP address of your host machine's network interfaces. This ensures that you configure Docker networks correctly and avoid IP conflicts.
### Inspect the Host’s Network from Outside the Container

To inspect the host's network from outside the container, you can use the following steps:

1. **List all network interfaces on the host:**
    ```bash
    ip link show
    ip addr
    ```

2. **Check the IP routing table to understand how traffic is routed:**
    ```bash
    ip route
    ```
![Image](https://github.com/user-attachments/assets/d7e5b3c3-9ed6-4e9c-a297-07aeb546e5f5)

CIDR Block: 172.31.80.0/20
Subnet Range: 172.31.80.0 — 172.31.95.255

| Address Type                   | Example             |
|--------------------------------|---------------------|
| Network Address                | 172.31.80.0         |
| Gateway (typically 2nd ip )    | 172.31.80.1         |
| Your EC2 IP                    | 172.31.88.220       |
| Broadcast Address last ip      | 172.31.95.255       |
|AmazonDNS server in your VPC    | 172.31.0.2          |  /etc/resolv.conf (Dhcp)

## What is DHCP?

**DHCP (Dynamic Host Configuration Protocol)** is a network protocol that automates the process of assigning network configuration details to devices on a network. When a device connects to a network, DHCP provides the following information:

- **IP Address**: A unique address for the device on the network.
- **Subnet Mask**: Defines the network and host portions of the IP address.
- **Gateway**: The default route for accessing external networks.
- **DNS Server**: Resolves domain names to IP addresses.




3. **Inspect the Docker bridge network on the host:**
    ```bash
    ip addr show docker0
    ```

4. **Verify connectivity to the host from an external machine:**
    - Use the `ping` command to test connectivity to the host's IP address.
    - Example:
        ```bash
        ping <host-ip-address>
        ```
### Notes
- Ensure that the subnet used for Docker networks does not overlap with the host's existing network.
- Use this information when creating custom networks like macvlan to avoid conflicts.
- If unsure, consult your network administrator for guidance.

## 1. Bridge Network

The **bridge network** is the default network that containers are connected to if no specific network is specified during container creation. It allows containers on the same host to communicate with each other while remaining isolated from external networks.

### Use Case
- Ideal for communication between containers on the same Docker host.
- Provides isolation from external networks.
### Steps to Inspect the Default Bridge Network

1. **List all Docker networks to identify the default bridge network:**
    ```bash
    docker network ls
    ```
![Image](https://github.com/user-attachments/assets/e964ad5e-e209-421e-812a-ac74a376f7a6)

2. **Inspect the default bridge network:**
    ```bash
    docker network inspect bridge
    ```
![Image](https://github.com/user-attachments/assets/f22edbf2-87a1-4f13-81d5-4c353af9b366) 



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
sudo docker network inspect bridge

sudo docker exec -it thor-cont ip addr 
sudo docker exec -it thor-cont ip route
sudo bridge link
```
![Image](https://github.com/user-attachments/assets/c968355c-43df-4125-8aef-558be60913ce)

![Image](https://github.com/user-attachments/assets/51d179f6-5d1b-402a-8e3d-985d696aa7b0) 
### Verifying Communication Between Containers

To verify that the containers `thor-cont`, `mjolnir-cont`, and `stormbreaker` can communicate with each other on the default bridge network, follow these steps:
1. **Connect to `thor-cont` and check connectivity with `mjolnir-cont` using its IP address:**
    ```bash
    docker exec -it thor-cont sh
    ```

2. **Ping `mjolnir-cont` using its IP address:**
    ```bash
    ping <mjolnir-cont-ip>
    ```
![Image](https://github.com/user-attachments/assets/22ceb60c-aad8-4aa0-82bc-14cd2291d1b6) 

4. **Test HTTP connectivity using `curl` (if applicable):**
    ```bash
    curl http://stormbreaker
    ``` 

6. **Ping `mjolnir-cont` from `stormbreaker`:**
    ```bash
    docker exec -it stormbreaker ping mjolnir-cont
    ```

### Notes
- Ensure that all containers are running and attached to the same network.
- If the containers cannot communicate, verify the network configuration using `docker network inspect bridge`.
- Use container names as hostnames for communication within the same network.
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


5. **Check open ports on the host:**
    ```bash
    sudo netstat -tuln
    ```

### Notes
- Ensure that the host's firewall rules allow external access to the required ports.
- Use these commands to troubleshoot network issues or verify the host's network configuration.
- For advanced debugging, tools like `tcpdump` or `wireshark` can be used to capture and analyze network traffic.