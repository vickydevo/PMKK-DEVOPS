# AWS VPC Explained with Apartment Community Analogy

## What is a VPC?

A **Virtual Private Cloud (VPC)** is a logically isolated section of AWS where you can launch AWS resources in a virtual network that you define. It’s like having your own private apartment community within AWS.

---

## Key Concepts

### 1. IP Address
An **IP address** is a unique identifier for a device on a network. In our analogy, each apartment (device) in the community has its own address.

### 2. Subnet
A **subnet** divides the VPC into smaller networks. Think of each block in the apartment community as a subnet.

### 3. CIDR Range
**CIDR (Classless Inter-Domain Routing) range** defines the IP address range for the VPC or subnet. For example, `10.0.0.0/16` for the whole community, and `10.0.1.0/24` for Block A.

### 4. Route Tables
**Route tables** control how traffic moves within the VPC. It’s like the internal roads and gates that direct vehicles (data) between blocks and outside.

### 5. Internet Gateway (IGW)
An **Internet Gateway** connects your VPC to the internet, like the main gate of the apartment community.

---


## Launching a Custom VPC through AWS Console (2 Public & 2 Private Subnets)

1. **Open AWS Management Console**  
    Go to the VPC dashboard.

2. **Create a VPC**  
    - Click "Create VPC".
    - Set the CIDR block (e.g., `10.0.0.0/16`).

3. **Create Subnets**  
    - Create two public subnets (e.g., `10.0.1.0/24`, `10.0.2.0/24`).
    - Create two private subnets (e.g., `10.0.3.0/24`, `10.0.4.0/24`).

4. **Create and Attach Internet Gateway (IGW)**  
    - Go to "Internet Gateways" > "Create Internet Gateway".
    - Attach the IGW to your VPC.

5. **Configure Route Tables**  
    - **Public Route Table**:  
      - Create a route table for public subnets.
      - Add a route: `0.0.0.0/0` → IGW.
      - Associate this route table with the two public subnets.
    - **Private Route Table**:  
      - Create a separate route table for private subnets.
      - Do not add a route to IGW.
      - Associate this route table with the two private subnets.

6. **Test Setup by Launching EC2 Instances**  
    - Launch an EC2 instance in a public subnet.
    - Assign a public IP.
    - SSH into the instance to verify internet connectivity.
    - Launch an EC2 instance in a private subnet (no public IP).
    - Verify that it cannot access the internet directly.

This configuration ensures public subnets have internet access via IGW, while private subnets remain isolated.


## Conclusion

A VPC is like an apartment community, with blocks as subnets, addresses as IPs, a main gate as IGW, and internal roads as route tables. You can custom configure each part to suit your needs.