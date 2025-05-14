#!/bin/bash

# Update and install openssh-server (if not already installed)
apt-get update -y
apt-get install -y openssh-server

# Backup the original sshd_config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Ensure necessary settings in sshd_config
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#*UsePAM.*/UsePAM yes/' /etc/ssh/sshd_config

# Restart SSH service
systemctl restart ssh
