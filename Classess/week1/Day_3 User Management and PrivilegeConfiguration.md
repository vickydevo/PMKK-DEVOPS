# Different IP addresses (Public IP, Private IP & Elastic IP)
--------------------------------------------------------------

**Public IP Address:** Temporary and automatically assigned by AWS for internet-facing instances; released when the instance is stopped.

**Private IP Address:** Used for internal network communication within a VPC; remains with the instance even when stopped.

**Elastic IP Address:** A static public IP that can be manually allocated and reassigned; persists across instance reboots and can be associated with different instances as needed.


# CONNECT EC2 Instance through VS Code
-------------------------------------

Edit `C:/Users/VIGNAN/.ssh/config` file with the below content:

```ssh
Host sudheer
 HostName  ec2-65-2-39-249.ap-south-1.compute.amazonaws.com
 IdentityFile C:/Users/VIGNAN/Downloads/VM.pem
 User ec2-user
```


# User Management and Privilege Configuration
---------------------------------------------

## 1. Create a User and Install Git

To create a user and install Git using `yum` or `apt`:

```sh
sudo useradd devops
sudo useradd -ms /bin/bash devops # For Ubuntu servers
sudo passwd devops  # Set a password for the user
```

To install Git:
```sh
sudo yum install git tree -y  # For RHEL-based systems
sudo apt install update -y   # For Debian-based systems
```

### Change the Current Shell Temporarily

```sh
bash   # Switch to Bash
sh     # Switch to sh
zsh    # Switch to Zsh (if installed)
exit   # Return to previous shell or press Ctrl+D
```

### Check Available Shells

```sh
cat /etc/shells
```

Example output:
```
/bin/sh
/bin/bash
/bin/dash
/bin/zsh
```


## 2. Grant Root Privileges to a Non-root User

If you encounter the error:
> devops is not in the sudoers file.

Edit sudoers:
```sh
sudo visudo
```
Add under `# User privilege specification`:
```sh
devops ALL=(ALL:ALL) NOPASSWD:ALL
```


## 3. List Users and Groups

### Show all users:
```sh
sudo cat /etc/passwd
getent passwd
```

### Show all groups:
```sh
sudo cat /etc/group
getent group
```

### Count total groups:
```sh
getent group | wc -l
```


## 4. Understanding `wc` Command

```sh
wc file.txt       # lines, words, bytes
wc -l file.txt    # only lines
```


## 5. Using `tee` Command

```sh
nl file1 | tee file1temp.txt && mv file1temp.txt filerenamed
```

- `nl` → Number lines
- `tee` → Duplicates output to a file


## 6. Group Management

### Create a new group:
```sh
sudo groupadd admins
```

### Add user to groups:
```sh
sudo usermod -aG admin devops
sudo usermod -aG wheel devops
```

### Set primary group:
```sh
sudo useradd -g admin devops
```

### Add user to multiple groups:
```sh
sudo useradd -G admin tester
```

### Check user group membership:
```sh
groups devops
```

Example output:
```
devops : devops admin
```


## Directory Structure Example
```sh
touch Linux/file1
mkdir -p Linux/amazon/root/ec2
cd Linux/amazon && touch file2
cd root && touch file3 && cd ec2 && touch file4
tree
```

Expected Output:
```
.
└── Linux
    ├── amazon
    │   ├── file2
    │   └── root
    │       ├── ec2
    │       │   └── file4
    │       └── file3
    └── file1
```


## 7. Manage Sudoers Configuration

### Add to sudoers file:
```sh
vi /etc/sudoers.d/admins
```

Add content:
```sh
# Created by Vignan on March 11, 2024

# Group rules for admins
%admins ALL=(ALL) NOPASSWD:ALL
```


## 8. Checking Group Membership

```sh
getent group wheel
getent group devops
```

Example:
```
devops:x:1002:arya,keerthi
```

### Remove user from group:
```sh
sudo gpasswd -d devops wheel
```


## 9. View Encrypted Passwords

```sh
sudo cat /etc/shadow
```


# Task - 2
----------

1. Create a directory with your name inside your last name directory  
2. Create a file inside your name directory and add text about yourself in 4 lines using redirection (no editor)  
3. Print the content of the file  
4. Use `sleep` command to delay execution  
5. Add comments for each step  


## Script

```bash
#!/bin/bash
clear
# Display Script Name, Author, Date at the top of the script
echo "###################################################"
echo "#   Project Name : Education sector               #"
echo "#   Script Name  : Create dir and file            #"
echo "#   Author       : Vignan                         #"
echo "#   Created on   : $(date)     #"
echo "###################################################"
sleep 3
echo "********************************************************************"
echo "creating training directory inside synchro.......... "
echo "*******************************************************************"
sleep 2
mkdir -p synchro/trainings
sleep 2
echo "*************************************************************************"
echo "creating a file and adding text without entering into file... "
echo "*******************************************************************"
sleep 2
echo "Devops, Security Analyst, junior software Developer" > ./synchro/trainings/info.txt
sleep 2
clear
echo "*******************************************************************"
echo " printing the text that was written in info.txt  ........"
echo "*******************************************************************"
cat synchro/trainings/info.txt
```

---