# Amazon Elastic Block Store (EBS) Overview

Amazon Elastic Block Store (EBS) is a scalable block storage service designed for use with Amazon EC2 instances. EBS manages and stores data in fixed-sized units called "blocks," similar to traditional hard drives or SSDs. It provides persistent storage that can be attached to EC2 instances, functioning like a physical hard drive connected to a server.

## Key Features of EBS

1. **Persistence**
    - Data on EBS volumes persists independently of the lifecycle of the EC2 instance.
    - If an EC2 instance is stopped or terminated, the data on the attached EBS volume remains intact.

2. **Elasticity**
    - EBS volumes can be resized and changed in type on the fly to accommodate changing workload requirements.

3. **Durability**
    - EBS volumes are designed for 99.999% availability, replicating data within its Availability Zone to protect against hardware failures.

4. **Snapshot**
    - EBS supports snapshots, which are incremental backups stored in Amazon S3.
    - Snapshots can be used to create new EBS volumes, restore existing volumes, or transfer data across regions.

5. **Encryption**
    - EBS supports encryption at rest using AWS KMS (Key Management Service).
    - Data is automatically encrypted as it moves between EBS and the EC2 instance.

6. **Multi-Attach (io1/io2)**
    - Allows multiple EC2 instances to attach to a single io1/io2 volume.
    - Useful for applications that require high availability.

## Volume Types

1. **General Purpose SSD (gp2, gp3)**
    - Balanced price and performance.
    - Suitable for a wide range of workloads.
    - gp3 offers baseline performance of 3,000 IOPS and allows you to provision additional IOPS and throughput independently (500 IOPS per GiB).
    - gp2 provides baseline performance of 3 IOPS/GB up to 16,000 IOPS.

2. **Provisioned IOPS SSD (io1, io2)**
    - Designed for latency-sensitive applications and workloads that require consistent high performance.
    - io1 and io2 can provide up to 64,000 IOPS (50 IOPS per GiB).
    - io2 offers higher durability (99.999%).

3. **Throughput Optimized HDD (st1)**
    - Low-cost HDD volume designed for frequently accessed, throughput-intensive workloads.
    - Network throughput is the rate at which data is transmitted over a network in a given time period, measured in bps, Mbps, or Gbps. Throughput is different from bandwidth, which is the maximum amount of data a network can transmit.
    - Suitable for big data, data warehouses, and log processing.

4. **Cold HDD (sc1)**
    - Lowest cost HDD volume designed for less frequently accessed workloads.
    - Suitable for colder data requiring fewer scans per day.

## Use Cases

- **Databases:** EBS volumes are commonly used to host databases, offering low-latency, high-performance storage.
- **File Systems:** EBS volumes can be attached to EC2 instances to host file systems that persist beyond the life of the instance.
- **Backup and Restore:** Snapshots provide a means of backing up data and restoring it in case of failure or disaster recovery.



# Amazon EBS: IOPS and Throughput

## What are IOPS and Throughput?

- **IOPS (Input/Output Operations Per Second):** Measures how many read/write operations a storage volume can handle per second.
- **Throughput:** Measures the amount of data transferred per second, typically in MiB/s.

## EBS Volume Types: IOPS & Throughput

| Volume Type | Min IOPS | Max IOPS | IOPS/GB | Min Throughput | Max Throughput | Throughput/GB |
|-------------|----------|----------|---------|----------------|---------------|---------------|
| gp2         | 100      | 16,000   | 3       | 100 MiB/s      | 250 MiB/s     | ~0.25 MiB/s/GB|
| gp3         | 3,000    | 16,000   | N/A     | 125 MiB/s      | 1,000 MiB/s   | N/A           |
| io1/io2     | 100      | 256,000  | 50      | 100 MiB/s      | 4,000 MiB/s   | N/A           |
| st1        | 500      | 500      | N/A     | 40 MiB/s       | 500 MiB/s     | N/A           |
| sc1        | 80       | 250      | N/A     | 12 MiB/s       | 250 MiB/s     | N/A           |


### Details

- **gp2:** IOPS scales at 3 IOPS per GB, up to 16,000 IOPS. Throughput maxes at 250 MiB/s.
- **gp3:** Baseline 3,000 IOPS and 125 MiB/s, can be provisioned up to 16,000 IOPS and 1,000 MiB/s, independent of volume size.
- **io1/io2:** Provisioned IOPS up to 256,000, at 50 IOPS per GB. Throughput up to 4,000 MiB/s.

> For more details, refer to [AWS EBS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html).

## Managing EBS Volumes

- **Attaching and Detaching:** EBS volumes can be dynamically attached to or detached from EC2 instances as needed.
- **Resizing:** Volumes can be resized (increased in size) without detaching from the instance; some changes may require a reboot.
- **Monitoring:** AWS CloudWatch provides metrics for monitoring EBS volume performance and usage.

## Pricing

- EBS pricing depends on volume type, provisioned storage, provisioned IOPS, and data transfer in/out of AWS.

## Best Practices

1. **Use Snapshots Regularly:** Take regular snapshots for data redundancy and disaster recovery.
2. **Monitor Performance:** Use CloudWatch to monitor volume performance and adjust types or sizes as needed.
3. **Implement Encryption:** Enable encryption for sensitive data to enhance security.
4. **Plan for Redundancy:** Use multiple volumes and snapshots across different Availability Zones for critical workloads.







<img width="968" height="633" alt="Image" src="https://github.com/user-attachments/assets/195d4689-1db5-4512-94b7-abbf94ba1cba" />

<img width="975" height="226" alt="Image" src="https://github.com/user-attachments/assets/130d2605-0411-4a1d-8c93-4087f6562d95" />

## Creating and Attaching an EBS Volume

### Configure and Create a Volume

1. **Configure Volume:**
    - **Volume Type:** Select from General Purpose SSD (gp2/gp3), Provisioned IOPS SSD (io1/io2), or Magnetic (st1/sc1).
    - **Size:** Enter the desired size in GiB.
    - **Availability Zone:** Choose the same zone as your target EC2 instance.
    - **Other Settings:** Set options like encryption as needed.
2. **Create:** Click “Create Volume” to provision the new EBS volume.

<img width="904" height="594" alt="Image" src="https://github.com/user-attachments/assets/aa97dc05-5c98-4195-9003-4e3e0b71cb04" />



<img width="975" height="352" alt="Image" src="https://github.com/user-attachments/assets/4633d38e-2df7-47f6-a805-43ccdd1aecd4" />

Once created, the volume will appear in the “Volumes” section and is ready to be attached.

<img width="975" height="296" alt="Image" src="https://github.com/user-attachments/assets/0cb2cf16-417a-4591-bd49-fcd949624070" />

### Attach Volume Using AWS Management Console

1. **Login to AWS Console:** Access the AWS Management Console.
2. **Go to EC2 Dashboard:** Select “EC2” from the Services menu.
3. **Navigate to Volumes:** Under “Elastic Block Store,” click “Volumes.”
4. **Select the Volume:** Ensure the volume is in the same availability zone as your EC2 instance.
5. **Attach Volume:**
    - Select the volume.
    - Click “Actions” > “Attach Volume.”
<img width="975" height="244" alt="Image" src="https://github.com/user-attachments/assets/100eb510-849d-408a-991f-037a40a4da33" />

6. **Configure Attachment:**
    - **Instance:** Choose the target EC2 instance.
    - **Device:** Specify the device name (e.g., `/dev/sdf`).

<img width="975" height="887" alt="Image" src="https://github.com/user-attachments/assets/318b59f3-95ae-4c27-8714-b8e309413173" />

7. **Attach:** Click “Attach Volume.”




### Prepare and Mount the Volume on Linux

1. **Check Detection:**
    - SSH into your EC2 instance.
    - Run `lsblk` or `sudo fdisk -l` to verify the new volume (e.g., `/dev/xvdf`) is detected.

<img width="975" height="329" alt="Image" src="https://github.com/user-attachments/assets/ab2d0333-2b3b-4bf0-a737-ec4251eb19bd" />

<img width="975" height="634" alt="Image" src="https://github.com/user-attachments/assets/a448f839-3071-45e1-9b46-113f1eab1232" />

2. **Format the Volume (if new):**
    - `sudo mkfs.ext4 /dev/xvdf`
    - Replace `ext4` with your preferred filesystem type.

<img width="975" height="360" alt="Image" src="https://github.com/user-attachments/assets/1ef5abc2-5b61-4c7a-bc0a-87a21da339b4" />

3. **Create Mount Point:**
    - `sudo mkdir /mnt/data`

4. **Mount the Volume:**
    - `sudo mount /dev/xvdf /mnt/data`
    - Verify with `df -h`.

    <img width="975" height="376" alt="Image" src="https://github.com/user-attachments/assets/f44e27df-67bd-4dca-88f2-d2054a6cc9ec" />
5. **Persist Mount (Optional):**
    - Add an entry to `/etc/fstab` for automatic mounting on reboot.
    - Test with:
      ```bash
      sudo umount /mnt/data
      sudo mount -a
      df -h
      ```

### Creating an EBS Snapshot

1. **Go to Snapshots:** In the EC2 Dashboard, under “Elastic Block Store,” click “Snapshots.”
2. **Create Snapshot:** Click “Create Snapshot.”
3. **Configure Snapshot:**
    - **Volume ID:** Select the source volume.
    - **Description:** Optionally add a description.
4. **Create:** Click “Create Snapshot” to begin.

Snapshots provide backup and disaster recovery for your EBS volumes.


# Expanding a Linux Partition and Filesystem

This guide explains the practical steps to increase the size of a partition and its filesystem on a Linux system using `growpart` and `resize2fs`.

## Why Use These Commands?

When you increase the size of a disk (for example, in a cloud environment), the new space is not automatically available to your existing partitions and filesystems. You must manually expand the partition and then resize the filesystem to utilize the additional space.

## Practical Steps

1. **Expand the Partition**
    - `sudo growpart /dev/nvme0n1 1`
    - This command grows the first partition (`1`) on the disk `/dev/nvme0n1` to occupy the newly available space.

2. **Resize the Filesystem**
    - `sudo resize2fs /dev/nvme0n1p1`
    - This command resizes the ext2/ext3/ext4 filesystem on the expanded partition (`/dev/nvme0n1p1`) to use all available space.

3. **Verify the Expansion**
    - `df -h`
    - This command displays disk space usage in a human-readable format, allowing you to confirm that the filesystem has been successfully expanded.

## Summary

By following these steps, you ensure that your Linux system can utilize the full capacity of a resized disk. Always back up important data before modifying disk partitions.


4. Configure fstab (Optional but Recommended)

To remount automatically on reboot:

Get UUID of the volume:

sudo blkid /dev/sdb


Edit fstab:

sudo nano /etc/fstab


Add an entry like:

UUID=<your-uuid>   /mnt/data   ext4   defaults,nofail   0   2








