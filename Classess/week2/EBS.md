# Amazon Elastic Block Store (EBS) Overview

![EBS Volume Creation](https://i.imgur.com/your-screenshot-link1.png)

Amazon Elastic Block Store (EBS) is a scalable block storage service designed for use with Amazon EC2 instances.

## Key Features

### 1. Persistence
- Data persists independently of EC2 instance lifecycle
- Data remains intact if instance is stopped/terminated

### 2. Elasticity
- Volumes can be resized and type changed dynamically

### 3. Durability
- 99.999% availability
- Data replicated within Availability Zone

### 4. Snapshot
- Incremental backups stored in S3
- Can create new volumes, restore, or transfer across regions

### 5. Encryption
- Encryption at rest using AWS KMS
- Automatic encryption during data transfer

### 6. Multi-Attach (io1/io2)
- Multiple EC2 instances can attach to single volume
- Useful for high availability applications

## Volume Types

| Type               | Description                                                                 | Use Cases                      |
|--------------------|-----------------------------------------------------------------------------|--------------------------------|
| General Purpose SSD (gp2/gp3) | Balanced price/performance (gp3: 3,000 IOPS baseline) | Wide range of workloads        |
| Provisioned IOPS SSD (io1/io2) | High performance (up to 64,000 IOPS) | Latency-sensitive applications |
| Throughput HDD (st1) | Low-cost HDD for throughput-intensive workloads | Big data, data warehouses      |
| Cold HDD (sc1)     | Lowest cost for infrequently accessed data                                  | Cold data storage              |

## Creating and Managing EBS Volumes

### 1. Creating a Volume
1. Navigate to EC2 Dashboard → EBS → Volumes
2. Click "Create Volume"
3. Configure settings:
   - Type (gp3, io2, etc.)
   - Size (GiB)
   - Availability Zone
   - Encryption

![alt text](image.png)
![alt text](image-1.png)
![alt text](image-2.png)
![alt text](image-3.png)

### Now you can see new EBS volume in the volume feature and available to attach
![alt text](image-4.png)
### 2. Attaching a Volume
1. Select volume → Actions → "Attach Volume"
  ![alt text](image-5.png)
2. Choose instance and device name
    ![alt text](image-6.png)
3. Click "Attach"



### 3. Mounting in Linux
```bash
# Check detected volumes
lsblk
![alt text](image-7.png)

```

# Format new volume (if needed)
```bash
sudo mkfs -t ext4 /dev/xvdf
![alt text](image-8.png)
````
```bash

# Create mount point
sudo mkdir /mnt/data
```
# Mount volume
```bash
sudo mount /dev/xvdf /mnt/data
![alt text](image-9.png)

# Verify
df -h