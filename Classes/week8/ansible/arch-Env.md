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

2. **Provide Root Access**  
    Grant root access to the created user on all servers.

3. **Generate and Exchange SSH Keys**  
    - Generate SSH keys on the Ansible controller node as the created user (e.g., `ansadmin`).  
    - Exchange the SSH keys with the managed nodes for the same user.

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