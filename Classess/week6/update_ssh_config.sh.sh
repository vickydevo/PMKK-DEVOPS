amazon server to ubuntu server through ssh-keygen then ssh-copy-id

#!/bin/bash
PUB_KEY=$1
PASS_AUTH=$2
SSH_CONFIG_PATH=${3:-/etc/ssh/sshd_config}  # Default path to /etc/ssh/sshd_config if not provided

# Update the PasswordAuthentication setting
if grep -q "^PasswordAuthentication" "$SSH_CONFIG_PATH"; then
    echo "*******************************************"
    echo "PasswordAuthentication line present"
    echo "*******************************************"

        sed -i "s/^PasswordAuthentication.*/PasswordAuthentication $PASS_AUTH/" "$SSH_CONFIG_PATH"
echo "*******************************************"
    echo "PasswordAuthentication line updated to $2"
    echo "*******************************************"

else
    echo "*******************************************"
    echo "PasswordAuthentication line is not present"
    echo "*******************************************"
    echo "PasswordAuthentication $PASS_AUTH" >> "$SSH_CONFIG_PATH"
fi

# Update the PubkeyAuthentication setting
if grep -q "^PubkeyAuthentication" "$SSH_CONFIG_PATH"; then
    sed -i "s/^PubkeyAuthentication.*/PubkeyAuthentication $PUB_KEY/" "$SSH_CONFIG_PATH"
else
    echo "*******************************************"
    echo "PubkeyAuthentication line is not present"
    echo "*******************************************"
    echo "PubkeyAuthentication yes" >> "$SSH_CONFIG_PATH"
fi

# Restart the sshd service
sudo systemctl restart sshd
--------------------------------------------------------------

#!/bin/bash
PUB_KEY=$1
PASS_AUTH=$2
SSH_CONFIG_PATH=$SSH_CONFIG_PATH

if grep "PasswordAuthentication"  $SSH_CONFIG_PATH;
 then 
 sed s/^PasswordAuthentication.*/PasswordAuthentication $2/ $SSH_CONFIG_PATH
 else 
   sleep 4
   echo "*******************************************"
   echo "PasswordAuthentication line is not present"
   echo "*******************************************"

   echo 'PasswordAuthentication yes' >>  $SSH_CONFIG_PATH
fi
   sudo systemctl restart sshd
# update the publickey authentication
if grep "PubkeyAuthentication"  $SSH_CONFIG_PATH;
 then 
 sed -i s/^PubkeyAuthentication.*/PubkeyAuthentication $1/ $SSH_CONFIG_PATH
 else 
   sleep 4
   echo "*******************************************"
   echo "PubkeyAuthentication line is not present"
   echo "*******************************************"

   echo 'PubkeyAuthentication yes' >>  $SSH_CONFIG_PATH
fi
   sudo systemctl restart sshd