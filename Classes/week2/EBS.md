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











