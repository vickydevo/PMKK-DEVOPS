You’ve captured the logic perfectly. This is the solid, professional way to set up a distributed Jenkins environment. Below is your **final, polished guide** with the commands cleaned up and the sequence optimized for success.

---

## 🛠️ Phase 1: Prepare the Slave Node (172.31.8.220)

Log into your **Slave** machine as the `ubuntu` user. These tools are required for the Jenkins agent and your Spring Boot Docker pipeline.

### 1. Install Java 21 (For the Agent & Build)
```bash
sudo apt update
sudo apt install openjdk-21-jdk -y
```

### 2. Install Docker & Set Permissions
```bash
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
# Refresh group membership without logging out
newgrp docker 
```

### 3. Install Unzip (For Maven Auto-Install)
```bash
sudo apt install unzip -y
```

---

## 🔑 Phase 2: SSH Security Setup (Master to Slave)

We need to give the Jenkins Master the "keys" to enter the Slave without a password.

### 1. Generate Keys on Jenkins Master
Run these as the **ubuntu** user on the Master server:
```bash
# Create the directory
sudo mkdir -p /var/lib/jenkins/.ssh

# Generate the RSA Key (Press ENTER for all prompts)
sudo ssh-keygen -t rsa -b 4096 -f /var/lib/jenkins/.ssh/id_rsa

# Fix Permissions so Jenkins owns the keys
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
sudo chmod 600 /var/lib/jenkins/.ssh/id_rsa
sudo chmod 644 /var/lib/jenkins/.ssh/id_rsa.pub
```

### 2. Share the Public Key with the Slave
On the **Master**, view the public key and copy the text:
```bash
sudo cat /var/lib/jenkins/.ssh/id_rsa.pub
```

On the **Slave**, open the authorized keys file:
```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
vi ~/.ssh/authorized_keys
# Paste the key string at the bottom, save and exit (:wq)
```

---

## 🖥️ Phase 3: Configure Node in Jenkins UI

1.  **Navigate:** Manage Jenkins > Nodes > **New Node**.
2.  **Basics:** Name: `Slave1` | Type: `Permanent Agent`.
3.  **Settings:**
    * **Remote root directory:** `/home/ubuntu`
    * **Labels:** `slave1` (Critical: matches your Jenkinsfile)
    * **Usage:** Only build jobs with label expressions matching this node.
4.  **Launch Method:** Launch agents via SSH.
    * **Host:** `172.31.8.220`
    * **Credentials:** Click **Add** > **Jenkins**.
        * **Kind:** `SSH Username with private key`
        * **ID:** `slave1-ssh-key`
        * **Username:** `ubuntu`
        * **Private Key:** Click "Enter directly" and paste the output of `sudo cat /var/lib/jenkins/.ssh/id_rsa` from your Master.
    * **Host Key Verification Strategy:** `Non verifying Verification Strategy`.

---

## ⚙️ Phase 4: Define Global Tools

Jenkins needs to know exactly what `m3` and `jdk21` mean in your script.

1.  Go to **Manage Jenkins** > **Tools**.
2.  **JDK Installations:**
    * **Name:** `jdk21`
    * **JAVA_HOME:** `/usr/lib/jvm/java-21-openjdk-amd64` (Verify this path on the slave with `readlink -f $(which java)`)
3.  **Maven Installations:**
    * **Name:** `m3`
    * Check **Install automatically**.

---

## ✅ Phase 5: The Test Run

Go back to **Manage Jenkins > Nodes**, click on **Slave1**, and select **Log** on the left menu.

> **Success looks like this:**
> `[04/09/26] [SSH] Starting agent process...`
> `Agent successfully connected and online`

### Why this works:
* **Decoupling:** By using the `ubuntu` user, you sidestep the headache of setting up a new user while still maintaining control.
* **Automatic Tooling:** Jenkins will now push the Maven binaries to the slave automatically because of the `tools` block.
* **Docker Ready:** Since `ubuntu` is in the `docker` group, your `sh "docker build..."` commands will run without needing `sudo`.

Ready to trigger your Spring Boot build and see it run on the new node?









































































































# Setting Up a Jenkins Slave Node (Agent) on AWS EC2 Using SSH  

## Prerequisites  
1. **Jenkins Master** already installed on an EC2 instance.  
2. **Slave Node** (another EC2 instance) with:  
    - Jenkins user created or Use default User(ubuntu).  
    - SSH access configured.  
    - Java installed.  

---

## Step-by-Step Guide  

### 1. Create and Configure the Slave EC2 Instance  
- Launch a new EC2 instance (slave) with appropriate specs (e.g., `t2.micro`).  
- Ensure the security group allows inbound traffic on port `22` (for SSH access).  
- Install Java on the slave:  
  ```bash  
  sudo apt update  # For Ubuntu/Debian  
  sudo apt install openjdk-21-jdk -y  
  java --version  # Verify Java installation  
  ```  

### 2. Create a Jenkins User on the Slave Node  
- On the slave EC2 instance, create a user for Jenkins:  
  ```bash  
  sudo adduser jenkins  
  sudo usermod -aG sudo jenkins  # Give sudo privileges if needed  
  ```  
- Switch to the `jenkins` user:  
  ```bash  
  su - jenkins  
  ```  

### 3. Configure SSH Keys for Jenkins Connection  
- Generate SSH keys on your Jenkins master instance:  
  ```bash  
  ssh-keygen -t rsa -b 4096 -C "jenkins-slave"  # Leave all prompts blank for defaults  
  ```  
- Copy the public key to the slave instance:  
  ```bash  
  ssh-copy-id jenkins@<slave-instance-public-ip>  
  ```  
  Alternatively, manually copy the contents of the public key (`~/.ssh/id_rsa.pub`) and add it to the `~/.ssh/authorized_keys` file on the slave node.  

### 4. Configure the Slave Node in Jenkins  
- On the Jenkins master web UI, go to **Manage Jenkins > Manage Nodes and Clouds > New Node**.  
- Provide a node name (e.g., `Slave1`) and select **Permanent Agent**.  
- Configure the following settings:  
  - **Remote root directory**: `/roo` (or the home directory of the `jenkins` user on the slave).  
  - **Usage**: Select the appropriate usage, such as "Use this node as much as possible."  
  - **Launch method**: Choose **Launch agents via SSH**.  
  - **Host**: Enter the public IP or DNS of the slave instance.  
  - **Credentials**:  
     - Add the SSH credentials for the `jenkins` user. In **Credentials**, select **Jenkins → Add → SSH Username with Private Key**.  
        - **Username**: `jenkins`  
        - **Private Key**: Select **Enter directly**, and copy-paste the private key (`~/.ssh/id_rsa`) from the master instance.  
  - **Host Key Verification Strategy**: You can choose **Manually trusted key Verification Strategy** for simplicity.  

### 5. Test the SSH Connection  
- Click on the **Save** button and Jenkins will attempt to connect to the slave via SSH.  
- If the connection is successful, the node status will show **Online**.  

### 6. Verify the Node is Running  
- Once the node is set up, it will appear under **Manage Nodes** with an **Online** status.  
- You can test by configuring a Jenkins job to run on this specific node using the **Restrict where this project can be run** option (set to the node’s label).  

---

## Troubleshooting  
- **Security Groups**: Ensure that the security group of the slave EC2 instance allows SSH (port `22`) from the master instance.  
- **Java**: Ensure that Java is installed and correctly configured on the slave instance.  
- **SSH Key**: Ensure that the SSH key permissions on the slave node are set to:  
  ```bash  
  chmod 600 ~/.ssh/authorized_keys  
  ```  

This should set up your Jenkins master to connect and use the EC2 slave node for running jobs.  

## Setting Up Webhooks in Git for Jenkins Pipeline Job  

### 1. Enable Webhooks in Your Git Repository  
- Go to your Git repository (e.g., GitHub, GitLab, or Bitbucket).  
- Navigate to **Settings > Webhooks**.  
- Click on **Add Webhook**.  

### 2. Configure the Webhook  
- **Payload URL**: Enter the Jenkins webhook URL. This is typically:  
    ```
    http://<jenkins-server-url>/github-webhook/
    ```  
    Replace `<jenkins-server-url>` with your Jenkins server's public URL.  
- **Content Type**: Select `application/json`.  
- **Events**: Choose the events to trigger the webhook. For example:  
    - **Just the push event** (recommended for most cases).  
    - Or **Let me select individual events** and choose specific events like `push` and `pull_request`.  
- Click **Add Webhook** to save the configuration.  

### 3. Configure Jenkins Pipeline Job to Use the Webhook
- In Jenkins, create or configure a pipeline job.  
- Under the **Build Triggers** section, enable **GitHub hook trigger for GITScm polling** (or the equivalent for your Git provider).  

### 4. Test the Webhook  
- Push a commit to the repository or trigger an event configured in the webhook.  
- Verify that Jenkins starts the pipeline job automatically.

### 5. Troubleshooting  
- **Webhook Delivery**: Check the webhook delivery logs in your Git repository to ensure the payload is sent successfully.  
- **Jenkins Logs**: Check the Jenkins logs for any errors related to the webhook.  
- **Firewall/Network**: Ensure that your Jenkins server is accessible from the internet if hosted on a private network.  

This setup ensures that your Jenkins pipeline job is triggered automatically whenever changes are pushed to the Git repository.