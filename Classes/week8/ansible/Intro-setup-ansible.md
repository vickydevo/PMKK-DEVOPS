# Introduction to Ansible  

## Overview  
Ansible is an open-source, command-line IT automation tool written in Python. It is widely used for automating tasks such as configuration management, application deployment, and system updates.  

## Key Features of Ansible  
- **Agentless Architecture**: No need to install agents on managed nodes.  
- **Push Model**: Executes tasks by pushing configurations from a central control node.  

## Use Cases  

### 1. Configure Systems  
Ansible can be used to configure systems efficiently.  
**Examples**:  
- Create a `dbadmin` user on all servers.  
- Open specific ports on all database servers.  

### 2. Deploy Software/Applications  
Ansible simplifies software and application deployment.  
**Examples**:  
- Install the `nc` command on all servers.  
- Install and configure a web server.  

### 3. Update Systems / Apply Patches  
Ansible helps in keeping systems up-to-date by applying patches and updates.  

### 4. Provisioning  
Ansible can provision servers, although tools like Terraform are often preferred for this purpose.  

## Why Use Ansible?  
- **Configuration Management**: Ensures systems are in the desired state.  
- **Automation**: Reduces manual effort and human error.  

Ansible is a powerful tool for IT automation, making it an essential part of modern DevOps practices.  

## Ways to Use Ansible  

We can use Ansible in two ways:  
1. **Ansible CLI Commands (Ad Hoc Commands)**: These are one-liner commands executed directly from the command line for quick tasks.  
2. **Ansible Playbooks**: Written in simple YAML files, playbooks allow for more complex and repeatable automation tasks.  

> **Note**: Both Ansible CLI Commands/Ad Hoc Commands and Ansible Playbooks rely on modules to perform tasks.  

## Ansible Distributions & Versions  

### Ansible and Ansible Playbooks for Automation  
Starting from version 2.10, Ansible is available in two distributions:  

1. **Ansible Core**  
    - The actual Ansible tool used to run ad hoc commands and playbooks.  
    - Comes with a minimal set of modules to work with your environment.  

2. **Ansible Community**  
    - Built on top of Ansible Core and includes community collections/modules.  
    - Allows for extended functionality by installing additional collections/modules as needed.  

### Key Points to Remember  
- You can install either Ansible Core or Ansible Community based on your project requirements.  
- Both distributions can be installed using the `pip` command.  
## Official Documentation  

For more detailed information and the latest updates, refer to the [official Ansible documentation](https://docs.ansible.com/).  
**![Image](https://github.com/user-attachments/assets/f5873f48-2e25-4972-927e-894aa47f541e)**
---
**![Image](https://github.com/user-attachments/assets/fa089a8f-598c-441b-be08-ac32b4e06b4e)**
### Release Notes and Maintenance Logs  

For detailed release notes and maintenance logs, navigate to the **Releases and Maintenance** section on the official Ansible documentation page.  

After clicking on **Releases and Maintenance**, scroll down to find the **Ansible Community Logs** section, as shown in the image below:  
![Image](https://github.com/user-attachments/assets/5c69c566-159a-41f2-b28b-095826d7be6c)  

This section provides insights into the latest updates, bug fixes, and changes in the Ansible Community distributions.  

### Ansible-Core Support Matrix  

To ensure compatibility, refer to the Ansible-Core support matrix for system requirements and supported versions:  
![Image](https://github.com/user-attachments/assets/b09a99c5-a322-4ec6-8e1a-2703d7184006)  

This matrix provides details about supported Python versions, operating systems, and dependencies for different Ansible-Core releases. 

### Setting Up Ansible Using WSL on Windows  

Windows Subsystem for Linux (WSL) allows you to run a Linux environment directly on Windows. Follow these steps to set up Ansible using WSL:  
#### Step 1: Enable WSL Feature  
1. Open PowerShell as Administrator.  
2. Run the following command to enable the WSL feature:  
![Image](https://github.com/user-attachments/assets/33ba8754-d6ec-42af-9359-a8f77abd40a7)
---
**![Image](https://github.com/user-attachments/assets/c904eb37-266f-4684-a7cc-e3d1e47420c9)**

---

#### Step 3: Restart Your Computer  
Restart your computer to apply the changes.  

#### Step 4: Install a Linux Distribution  
1. Open the Microsoft Store.  
2. Search for your preferred Linux distribution (e.g., Ubuntu).  
3. Click **Install** to download and install the distribution.  

#### Step 5: Set Up the Linux Distribution  
1. Launch the installed Linux distribution from the Start menu.  
2. Follow the on-screen instructions to complete the setup (e.g., creating a username and password).  

#### Step 6: Update WSL to WSL 2 (Optional)  
1. Download the latest WSL 2 kernel update package from the [Microsoft WSL documentation](https://aka.ms/wsl2kernel).  
2. Install the package.  
3. Set WSL 2 as the default version:  
  ```bash  
  wsl --set-default-version 2  
  ```  

#### Step 7: Verify WSL Installation  
To check the installed WSL version and distributions, run:  
```bash  
wsl -l -v  
```  

> **Note**: Ensure that your Windows version supports WSL 2. You can check this in the [WSL documentation](https://docs.microsoft.com/en-us/windows/wsl/install).  



#### Step 2: Set Default WSL Distribution  
To set a specific distribution as the default, use:  
```bash  
wsl -s <distribution_name>  
```  
For example, to set Ubuntu as the default:  
```bash  
wsl -s Ubuntu  
```  

#### Step 3: Shutdown WSL  
To shut down all running WSL distributions, use:  
```bash  
wsl --shutdown  
``` 
--- 
### Alternative Installation Methods  

Ansible can be installed in various ways depending on your operating system and requirements. Refer to the [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#) for detailed instructions.  

#### Installation Methods:  
1. **Using Package Managers**:  
    - For Red Hat-based systems:  
      ```bash  
      sudo yum install ansible  
      ```  
    - For Debian-based systems:  
      ```bash  
      sudo apt install ansible  
      ```  

![Image](https://github.com/user-attachments/assets/2cbdb7b9-0c21-4e63-a4cb-2c6b81798c9b)  

> **Note**: Choose the installation method that best suits your environment and project requirements.  

**![Image](https://github.com/user-attachments/assets/1d5a2416-e1fc-4e66-aa28-5344a93bc860)**


#### Step 4: Install Ansible in WSL  
Before installing Ansible, ensure that `pip3` is available. You can install it using the following command:

```bash
sudo apt update
sudo apt install python3-pip
```
Once inside your WSL distribution (e.g., Ubuntu), you can install Ansible using `pip3`:  
```bash  
pip3 install ansible==10.0.1
OR
pip3 install ansible-core==2.17 
```  
**![Image](https://github.com/user-attachments/assets/06dfb3ca-edef-4966-bed7-b4627a05e833)**

### Installing Ansible Using pipx

You can also install Ansible using [pipx](https://pypa.github.io/pipx/), which helps you run Python applications in isolated environments.

#### Step 1: Install pipx

```bash
sudo apt update
sudo apt install pipx
```

#### Step 2: Ensure pipx is in Your PATH

```bash
pipx ensurepath
```

Restart your terminal or source your shell configuration:

```bash
source ~/.bashrc   # or ~/.zshrc
```

#### Step 3: Install Ansible (e.g., version 2.17)

```bash
pipx install ansible-core==2.17
```

#### Step 4: Verify Installation

```bash
ansible --version
```

If you see `Command 'ansible' not found`, add pipx's binary directory to your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

To make this change permanent, add it to your shell config:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### 📦 Uninstall or Upgrade Ansible

To upgrade Ansible:

```bash
pipx upgrade ansible-core
```

To uninstall Ansible:

```bash
pipx uninstall ansible-core
```

#### Step 5: Verify Installation  
To confirm that Ansible is installed, run:  
```bash  
ansible --version  
```  