
# What is Amazon EKS?

**Amazon EKS (Elastic Kubernetes Service)** is a fully managed Kubernetes service by AWS that makes it easy to run Kubernetes on AWS without needing to install and operate your own Kubernetes control plane or nodes.

EKS automatically manages the availability and scalability of the Kubernetes control plane nodes responsible for:

- Scheduling containers
- Managing the application's availability
- Storing cluster data
- Performing other key operational tasks

By using Amazon EKS, you can take advantage of the performance, scale, reliability, and availability of AWS infrastructure while using standard Kubernetes tooling and APIs to manage your applications.


# Create Amazon EKS Cluster using `eksctl` with IAM Roles

This guide helps you set up an Amazon EKS (Elastic Kubernetes Service) cluster using `eksctl`, including setting up IAM roles for the cluster and the node group.



## ✅ Prerequisites

### 1 Install `eksctl`
```bash
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
````

### 2 Install AWS CLI and configure:

```bash
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
```

```bash
aws configure
```
**![Image](https://github.com/user-attachments/assets/de2fa9f5-2be9-410e-8c30-02f391b851c5)**
Ensure your AWS IAM user has permissions to create IAM roles, EC2, and EKS resources.

---
### 3 Install kubectl (Kubernetes CLI)

To interact with the EKS cluster, install `kubectl` using the following commands:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --client
```
## ✅ Step 1: Create IAM Role for EKS Cluster

### 1. Create trust policy for EKS control plane (trust-policy.json)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### 2. Create and attach the cluster role:
## 📌 What is `AmazonEKSClusterPolicy`?

`AmazonEKSClusterPolicy` is a **managed IAM policy** provided by AWS that grants necessary permissions for the **EKS control plane** to function correctly.

## 🔐 What permissions does it provide?

The policy allows EKS to:

- ✅ Create and manage networking resources (e.g., VPC, subnets, ENIs)
- ✅ Communicate with other AWS services like:
  - EC2 (Elastic Compute Cloud)
  - Auto Scaling
  - ELB (Elastic Load Balancer)
- ✅ Access EC2 instances for:
  - Bootstrapping nodes
  - Performing health checks

## ⚠️ Why is it important?

Without attaching this policy to your EKS control plane IAM role, your Kubernetes cluster may not function properly, as the control plane would lack the permissions needed to:

- Manage cluster networking
- Launch and scale worker nodes
- Interact with required infrastructure services

```bash
aws iam create-role --role-name EKSClusterRole \
  --assume-role-policy-document file://trust-policy.json
```


### ✅ Use this AWS CLI command to attach the policy:

```bash
aws iam attach-role-policy \
  --role-name EKSClusterRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
---

## ✅ Step 2: Create IAM Role for Node Group

### 1. Create trust policy for EC2 worker nodes (trust-node-policy.json)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### 2. Create and attach the node role:

```bash
aws iam create-role --role-name EKSNodeRole \
  --assume-role-policy-document file://trust-node-policy.json
```
**![Image](https://github.com/user-attachments/assets/ba0d3d7e-d539-4748-a7d1-5928a88bc323)**
```bash
aws iam attach-role-policy --role-name EKSNodeRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy

aws iam attach-role-policy --role-name EKSNodeRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly

aws iam attach-role-policy --role-name EKSNodeRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
```

---

## ✅ Step 3: Create EKS Cluster using `eksctl`

### Create a file named `eks-cluster.yaml`

```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: my-eks-cluster
  region: us-west-2

iam:
  withOIDC: true
  serviceRoleARN: arn:aws:iam::<account-id>:role/EKSClusterRole

nodeGroups:
  - name: ng-1
    instanceType: t3.medium
    desiredCapacity: 2
    iam:
      instanceRoleARN: arn:aws:iam::<account-id>:role/EKSNodeRole
```

> 🔁 Replace `<account-id>` with your actual AWS account ID.
## 🔐 Why `withOIDC: true` is Important in EKS

Setting `withOIDC: true` in your EKS cluster configuration enables the creation of an **OIDC identity provider**, which is required for using **IAM Roles for Service Accounts (IRSA)**.

This allows you to:

- Assign fine-grained IAM permissions to individual pods
- Avoid storing AWS credentials inside containers
- Follow AWS security best practices by applying least-privilege access at the pod level

By enabling OIDC, you make your cluster more secure and production-ready.


### Run the following command to create the cluster:

```bash
eksctl create cluster -f eks-cluster.yaml
```

---

✅ Your EKS cluster will be up and running in a few minutes.
## Enable IAM OIDC Provider

Although `withOIDC: true` is specified in `eks-cluster.yaml`, if you reused a CloudFormation stack or encountered issues during creation, the OIDC provider might not be attached.

To manually attach the OIDC provider (required for IAM Roles for Service Accounts):

```bash
eksctl utils associate-iam-oidc-provider \
  --region us-east-1 \
  --cluster my-eks-cluster \
  --approve

---
