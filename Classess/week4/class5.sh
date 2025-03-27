
Date: 26/02/2024  MONDAY
Class DEVOPS [ morning]  :  
-------------------------------------

# COPY: (cp)
----------
     copy file from one to another directory while keep original in the same place
       cp <src> <des>\

# MOVE (mv)
--------------
    move file from one to another directory or renaming the file name
       mv <src> <des>
# which shell find
    echo $SHELL
    cat /etc/shells
_________________
/bin/bash
/usr/bin/bash
/bin/rbash
/usr/bin/rbash
/usr/bin/sh
/bin/dash
/usr/bin/dash
/usr/bin/tmux
/usr/bin/screen
_________________

****************************
#!/bin/bash

# Prompt for the username
read -p "Enter Username : " USERNAME
# echo $USERNAME
# Prompt for the password value and mask the value [-s ref to secret]
read  -s -p  "Enter passwd:" PASSWD
read -p "Enter Training centre name : " $TRAINING_CENTRE
echo $TRAINING_CENTRE
read -p "Enter directory" dirname
echo $dirname
read -p "Enter filename : " filename
# create new user [-m ref to create new directory for user]   [-p, --password PASSWORD The encrypted password]
sudo useradd -m -p $(openssl passwd -1 "$PASSWD") "$USERNAME"
echo "create new user with masked passwd is created ........"
sudo su - $USERNAME << EOF
# Create directory named "training_center"
mkdir "$dirname"

# Create file inside the directory
cat <<EOT > "$dirname/$filename"
Welcome to our $TRAINING_CENTRE!

We provide a variety of training programs including:
- IT Certification Courses
- Programming Bootcamps
- Data Science Workshops
- Leadership and Management Training
- Soft Skills Development Sessions

Contact us for more information on our offerings and schedules.
EOT
cat "$dirname/$filename"
EOF

echo "User '$USERNAME' has been created with a training directory and information."
******************************
Date: 24/02/2024  SATURDAY
Class DEVOPS [ morning]  :  
-------------------------------------
vscode installation 
Remote aws host connecting with vscode

1.install vscode w.r.t operating system 
2.open vscode and click extension boxes on left bar
3.type remote ssh and install that in vscode as extension
4.an icon will appear which is screen click on it then on top of vscode c
   connect to host --- click on it 
   copy the ssh -i "keypair.pem" user@ip-address
   linux --click on it
   continue
if it does not connect then check open ssh configuration file [C:/Users/youruser/.ssh/config] with below details
Host bash_script
    HostName ec2-3-121-47-34.ap-south-1.compute.amazonaws.com
    IdentityFile C:/Users/youruser/Downloads/yourkeypair.pem
    User ec2-user