# Ansible and Ansible Playbooks for Automation

## Overview
Ansible is a powerful tool used in various areas of IT automation. It simplifies configuration management, application deployment, and orchestration tasks.

---

## How to Work with Remote Servers Using Ansible?
Ansible allows you to manage remote servers efficiently by leveraging its agentless architecture and SSH-based communication.

---
*![Image](https://github.com/user-attachments/assets/bab5c08f-5253-4a03-b25f-2acbf7a67da1)*

## Important Points to Remember

1. **Ansible Uses SSH Connection to Work with Remote Servers**  
    Ansible connects to remote servers using SSH, ensuring secure and seamless communication.

2. **Agentless Tool**  
    Ansible does not require any agent installation on the managed nodes, making it lightweight and easy to use.

3. **How Ansible Executes/Completes Any Operation?**  
    Ansible uses playbooks (written in YAML) to define tasks. These tasks are executed sequentially on the target machines.

4. **Ansible Follows Push Model & Agentless Architecture**  
    Ansible pushes configurations and commands from the control node to the managed nodes without requiring any pre-installed software on the target systems.

---
## Configuring Ansible for Your Project

### Steps to Set Up Ansible

1. **Create a User Across All Servers**  
    Create a unique user (e.g., `ansadmin`, `automation`, `devops`, or `cloudadmin`) on all servers.
       
       ```bash
        useradd -ms /bin/bash ansadmin 
      ```
2. **Provide Root Access**  
    Grant root access to the created user on all servers.
      
    ```bash
    echo 'ansadmin ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ansadmin
    ```
    This command adds the `ansadmin` user to the sudoers file with root privileges, allowing it to execute commands as root without a password.
3. **Generate and Exchange SSH Keys**  
    - Generate SSH keys on the Ansible controller node as the created user (e.g., `ansadmin`).  

  ```bash
    ssh-keygen
    ```
    **![Image](https://github.com/user-attachments/assets/4dae8ce6-b428-4981-816f-ddbad0e37e2e)**

    - Exchange the SSH keys with the managed nodes for the same user.
    ```bash
    # Edit the sshd_config file to ensure the following lines are present and not commented:
    sudo nano /etc/ssh/sshd_config

    # Add or ensure these lines exist:
    PasswordAuthentication yes
    KbdInteractiveAuthentication yes
    UsePAM yes

    # Save the file and restart the SSH service:
    sudo systemctl restart sshd
    sudo systemctl restart ssh

    ```
    ```bash
    ssh-copy-id ansadmin@<managed-node-ip>
    ```
    Replace `<managed-node-ip>` with the IP address or hostname of the managed node. Repeat this step for each managed node to transfer the public key.
**![Image](https://github.com/user-attachments/assets/8bcb3ee5-ed13-4a39-a9da-b4eb00705bb6)**
3.1 **Verify Public Key on Managed Nodes**  
    Ensure the public key has been added to the `~/.ssh/authorized_keys` file of the created user (`ansadmin`) on each managed node. You can verify this by checking the contents of the file:

    ```bash
    cat ~/.ssh/authorized_keys
    ```
![Image](https://github.com/user-attachments/assets/a8f59568-1a29-40a7-9fe6-a37a6e7612a3)
    The public key from the Ansible controller node should be listed in this file. If it is not present, manually append the public key to the file.
4. **Switch to the Created User on the Controller Node**  
    Log in to the Ansible controller node and switch to the created user (e.g., `ansadmin`).

5. **Create a Project Directory**  
    Create a directory for your project, e.g., `/ansadmin/myproject`.

6. **Verify Connectivity**  
    Test the connection from the Ansible controller node to the managed nodes using the following commands:  
    ```bash
    ansible all -m ping
    ansible all -m ansible.builtin.ping
    ```

    ### Additional Steps for Your Project Directory

    1. **Create an Inventory File**  
        Under your project directory, create an inventory file with any name (e.g., `inventory`). This file should contain the IP addresses or FQDNs of the managed nodes.

    2. **Create an `ansible.cfg` File**  
        Create an `ansible.cfg` file in your project directory to define configuration settings for your Ansible environment.

    ---

    ### Notes

    - **Using Ansible Without SSH Keys**  
      You can use Ansible with a username and password instead of SSH keys by specifying the `--ask-pass` option when running Ansible commands.

    - **Using Ansible Without a Dedicated User (e.g., `ansadmin`)**  
      Ansible can also be configured to work with existing users on the managed nodes. Ensure the user has the necessary permissions to execute tasks.