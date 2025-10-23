# 🔑 SSH Key Setup and Deployment Guide

This guide outlines the sequential steps to create a new, dedicated SSH key pair (named `ansible-demo`), use an existing working key (`private.pem`) to gain temporary access, and deploy the new public key to a remote server (`98.84.57.26`).

## Prerequisites

  * You must have **temporary working access** to the remote server using an existing key (here, assumed to be `~/private.pem`).
  * The remote server's SSH daemon is configured for **public key authentication** (`PubkeyAuthentication yes`), which is the secure default on cloud images.
  * The username for the remote server is **`ec2-user`**.

-----

## Step 1: Generate a New SSH Key Pair

Create a new ED25519 key pair dedicated for use with Ansible. The files will be saved in your `~/.ssh/` directory.

```bash
# Generate a new key pair using the ED25519 algorithm.
# The private key is saved as 'ansible-demo' and the public key as 'ansible-demo.pub'.
ssh-keygen -t ed25519 -f ~/.ssh/ansible-demo
```

-----

## Step 2: Load the Existing Key into the SSH Agent

To run `ssh-copy-id`, you need to authenticate first. We'll use the SSH Agent to securely manage your **existing, working private key** (`private.pem`) for this initial login.

```bash
# 1. Start the SSH agent process and configure the current shell session.
eval "$(ssh-agent -s)"

# 2. Add your existing, working private key ('private.pem') to the agent.
# You will be prompted for the passphrase if one was set on this key.
ssh-add /home/ansadmin/private.pem
```

-----

## Step 3: Copy the New Public Key to the Target Server

Use `ssh-copy-id`. It will use the key loaded in the agent (from Step 2) to log in, and then copy your **new** public key (`ansible-demo.pub`) to the remote user's `~/.ssh/authorized_keys` file.

```bash
# Deploy the NEW public key (ansible-demo.pub) to the remote server.
# Authentication for this step is handled by the 'private.pem' key loaded in the agent.
ssh-copy-id -i ~/.ssh/ansible-demo.pub ec2-user@98.84.57.26
```

-----

## Step 4: Verify the New Key Connection

Confirm that the new key is installed and can be used for password-less connection.

```bash
# Test the connection by specifying the NEW private key using the -i flag.
ssh -i ~/.ssh/ansible-demo ec2-user@98.84.57.26
```

**Result:** You should log in successfully to the EC2 instance using the `ansible-demo` without being prompted for a password. This key is now ready for use in your Ansible inventory.