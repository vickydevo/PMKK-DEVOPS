#!/bin/bash
# Update the system
























java -jar /home/ec2-user/springboot-hello/target/gs-spring-boot-0.1.0.jar


nohup java -jar /home/ec2-user/springboot-hello/target/gs-spring-boot-0.1.0.jar > output.log 2>&1 &


sudo yum update -y

# Install Apache HTTP server (httpd)
sudo yum install httpd -y

# Start the httpd service and enable it to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Fetch the hostname and private IP address of the instance
HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Create a custom index.html file with server details
echo "<html>
<head><title>Server Details</title></head>
<body>
<h1>Server Details</h1>
<p><strong>Hostname:</strong> $HOSTNAME</p>
<p><strong>IP Address:</strong> $PRIVATE_IP</p>
</body>
</html>" | sudo tee /var/www/html/index.html

# Restart httpd to ensure the new index.html is served
sudo systemctl restart httpd




































sudo yum update -y

# Install Git
sudo yum install git -y
sleep 10


# Install Java 17 (Amazon Corretto)
sudo yum install java-17-amazon-corretto -y

# Install Docker
sudo yum install docker -y
sudo service docker start
sleep 10  # Wait 10 seconds for Docker to start

sudo usermod -a -G docker ec2-user  # Add ec2-user to Docker group

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '(?<=tag_name": ")[^"]*')" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Test network connectivity
ping -c 4 github.com >> /var/log/network-test.log 2>&1

# Check Git installation
git --version >> /var/log/git-version.log 2>&1

# Clone the Spring Boot application repository
git clone https://github.com/vickydevo/springboot-hello.git >> /var/log/git_repo_user-data.log 2>&1

cd springboot-hello

# Pull the pre-built Spring Boot Docker image
docker pull vignan91/springboot

# Deploy using Docker Compose
docker-compose up -d
