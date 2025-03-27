# Different IP addresses (Public IP, Private IP & Elastic IP)
--------------------------------------------------------------
    Public IP Address: Temporary and automatically assigned by AWS for internet-facing instances;
                        released when the instance is stopped.
   
    Private IP Address: Used for internal network communication within a VPC;   
                        remains with the instance even when stopped.
   
    Elastic IP Address: A static public IP that can be manually allocated and reassigned;   
                        persists across instance reboots and can be associated with different instances as needed.


CONNECT EC2 Instance through VScode
-------------------------------------
edit C:/Users/VIGNAN/.ssh/config file with below content
   Host sudheer
    HostName  ec2-65-2-39-249.ap-south-1.compute.amazonaws.com
    IdentityFile C:/Users/VIGNAN/Downloads/VM.pem
    User ec2-user


****************************************************************************
User Management and Privilege Configuration
****************************************************************************

## 1. Create a User and Install Git

To create a user and install Git using `yum` or `apt`:
```sh
sudo useradd devops
sudo useradd -ms /bin/bash devops # For ubuntu servers
sudo passwd devops  # Set a password for the user
```

1. Change the Current Shell Temporarily
If you want to switch to another shell just for the current session, run:

sh
Copy
Edit
bash   # Switch to Bash
sh     # Switch to sh
zsh    # Switch to Zsh (if installed)
To return to your previous shell, type:

sh
Copy
Edit
exit
or press Ctrl+D.

Check Available Shells
Run:

sh
Copy
Edit
cat /etc/shells
This will list installed shells. Example output:

bash
Copy
Edit
/bin/sh
/bin/bash
/bin/dash
/bin/zsh


To install Git:
```sh
sudo yum install git tree -y  # For RHEL-based systems
sudo apt install update  -y  # For Debian-based systems
```

## 2. Grant Root Privileges to a Non-root User

If you encounter the error:
```
devops is not in the sudoers file.
```
Follow these steps:

1. Open the sudoers file:
   ```sh
   sudo visudo
   ```
2. Add the following line under `# User privilege specification`:
   ```sh
   devops    ALL=(ALL:ALL) NOPASSWD:ALL
   ```
   or
   ```sh
   devops    ALL=(ALL) NOPASSWD: ALL
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

The `wc` command counts lines, words, and characters in a file.
```sh
wc file.txt
```
Example output:
```
 10   50   200 file.txt
```
- `10` → Number of lines
- `50` → Number of words
- `200` → Number of bytes

### Count only lines:
```sh
wc -l file.txt
```

## 5. Using `tee` Command

The `tee` command reads from standard input and writes to standard output and files.
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
explain below? 
useradd -G admin tester

### Check user group membership:
```sh
groups devops
```
Example output:
```
devops : devops admin
```
[tester@ip-172-31-21-65 ~]$ [tester@ip-172-31-21-65 ~]$ touch Linux/file1
[tester@ip-172-31-21-65 ~]$ touch Linux/amazon/file2
[tester@ip-172-31-21-65 ~]$ touch Linux/amazon/root/file3
[tester@ip-172-31-21-65 ~]$ touch Linux/amazon/root/ec2/file4
[tester@ip-172-31-21-65 ~]$ tree
.
└── Linux
    ├── amazon
    │   ├── file2
    │   └── root
    │       ├── ec2
    │       │   └── file4
    │       └── file3
    └── file1
try above in new created user
## 7. Manage Sudoers Configuration


```

#### Add the following content:
```
# Created by Vignan on March 11, 2024

# Group rules for admins
%admins ALL=(ALL) NOPASSWD:ALL
```

## 8. Checking Group Membership

To check users in a specific group:
```sh
getent group wheel
getent group devops
```
Example output:
```
devops:x:1002:arya,keerthi
```

1. Using gpasswd (Recommended)
The gpasswd command can be used to remove a user from a group:

sh
Copy
Edit
sudo gpasswd -d devops wheel
This removes the user devops from the wheel group.

## 9. View Encrypted Passwords

To display the `/etc/shadow` file containing user password hashes:
```sh
sudo cat /etc/shadow
```

---


### Copy sudoers configuration:
```sh
sudo cp /etc/sudoers.d/90-* /etc/sudoers.d/admins
```

### Edit sudoers file (Amazon Linux EC2):
```sh
vi /etc/sudoers.d/admins


****************************************************************************
****************************************************************************




Task -2
--------
1.create  a directory with yourname inside yourlastname directory
2.create a file inside yourname directory and add text about yourself in a 4line 
   without entering into file use redirection operator
3. print the content of a file you have written
4.sleep command to delay the execution
5. print the comments for each step




Script
--------------------------------------------------------------------------
#!/bin/bash
clear
# Display  Script Name, Author , Date at the top of the script
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
# rm -rfv synchro
------------------------------------------------------------------------------------------------------



https://www.youtube.com/watch?v=LpgQDfWOYCY