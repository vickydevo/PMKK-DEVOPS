# Ansible Architecture and Controller/Node Setup (SSH)

---

## How to Work with Remote Servers Using Ansible?
Ansible manages remote servers using an agentless, SSH-based model. The control node pushes tasks (from playbooks written in YAML) over SSH to managed nodes.

---

![Image](https://github.com/user-attachments/assets/bab5c08f-5253-4a03-b25f-2acbf7a67da1)

## Important Points to Remember

1. **Ansible Uses SSH**  
    Ansible connects to remote servers over SSH for secure communication.

2. **Agentless**  
    No agent is required on managed nodes.

3. **Execution Model**  
    Tasks are defined in playbooks (YAML) and executed sequentially.

4. **Push Model**  
    The control node pushes configuration and commands to managed nodes.

---

# 🔑 SSH Key Setup and Deployment Guide

## Prerequisites
- You have temporary working access to the remote server using an existing key (example: `~/private.pem` or `/home/ansadmin/private.pem`).
- The remote server permits public-key authentication (`PubkeyAuthentication yes`).
- Remote username (example): `ec2-user`.

## Step 1 — Generate a New SSH Key Pair
Create an ED25519 key pair for Ansible in `~/.ssh/`:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/ansible-demo
```

![Image](https://github.com/user-attachments/assets/4dae8ce6-b428-4981-816f-ddbad0e37e2e)

This creates `~/.ssh/ansible-demo` (private) and `~/.ssh/ansible-demo.pub` (public).

## Step 2 — Load the Existing Key into the SSH Agent
Load your working private key so `ssh-copy-id` can authenticate:

```bash
eval "$(ssh-agent -s)"
ssh-add /home/ansadmin/private.pem
```

## Step 3 — Copy the New Public Key to the Target Server
Use `ssh-copy-id` (agent handles initial auth with the existing key) to install the new public key:

```bash
ssh-copy-id -i ~/.ssh/ansible-demo.pub ec2-user@98.84.57.26
```

![Image](https://github.com/user-attachments/assets/8bcb3ee5-ed13-4a39-a9da-b4eb00705bb6)

You can also run, per managed node:

```bash
ssh-copy-id ansadmin@<managed-node-ip>
```

Replace `<managed-node-ip>` with the node's IP/hostname.

## Step 4 — Verify the New Key Connection
Test login with the newly created private key:

```bash
ssh -i ~/.ssh/ansible-demo ec2-user@98.84.57.26
```

If successful, you can now use `ansible-demo` in your inventory.

## Verify Public Key on Managed Nodes
On each managed node, verify the public key exists in the user's authorized keys:

```bash
cat ~/.ssh/authorized_keys
```

The controller's public key (`ansible-demo.pub`) should be listed. If missing, append it manually.

![Image](https://github.com/user-attachments/assets/a8f59568-1a29-40a7-9fe6-a37a6e7612a3)

## Post-Setup Tasks
4. Switch to the created user on the controller (e.g., `ansadmin`).
5. Create a project directory, e.g., `/home/ansadmin/myproject`.
6. Verify connectivity from the controller:

```bash
ansible all -m ping
ansible all -m ansible.builtin.ping
```

---

### Troubleshooting: "No inventory was found"
If Ansible reports no inventory:

1. Specify the inventory explicitly:

```bash
ansible all -m ansible.builtin.ping -i inventory
```

2. Check default inventory locations and `ansible.cfg`:
- Default system inventory: `/etc/ansible/hosts`
- Project inventory: `./inventory`

Set a custom inventory in `ansible.cfg`:

```ini
[defaults]
inventory = /path/to/inventory
```

Ansible will use this file if no `-i` is provided.

3. Validate inventory format. Example:

```ini
[webservers]
192.168.1.10
192.168.1.11

[dbservers]
192.168.1.20
```

![Image](https://github.com/user-attachments/assets/b3900610-3761-4506-a363-6256d644a66a)

---

### Disabling Host Key Checking (optional)
To bypass host key verification prompts temporarily:

```bash
export ANSIBLE_HOST_KEY_CHECKING=False
```

Or in `ansible.cfg` (project-wide):

```ini
[defaults]
inventory = ./inventory
host_key_checking = False
```

Place `ansible.cfg` in your project directory or another location Ansible will detect.
