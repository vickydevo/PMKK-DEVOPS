# SonarQube

## What is SonarQube?
SonarQube is an open-source platform for continuous inspection of code quality. It performs automatic reviews of code to detect bugs, vulnerabilities, and code smells, ensuring maintainability and reliability.

## Supported Languages
SonarQube supports a wide range of programming languages, including but not limited to:
- Java
- Python
- JavaScript
- C#
- C/C++
- PHP
- Ruby
- Kotlin
- Go
- Swift

## Why is it Mainly Used for Java?
SonarQube is widely used in Java projects because:
- Java is a popular enterprise language with complex codebases.
- It provides robust support for Java-specific rules and plugins.
- It integrates seamlessly with Java build tools like Maven and Gradle.

## Default Port
The default port for accessing the SonarQube web interface is **9000**.

## Installation Setup of SonarQube

### Installing SonarQube on an EC2 Instance

1. **Launch an EC2 Instance**:
    - Choose an Amazon Linux 2 or Ubuntu AMI.
    - Select an instance type with at least 2 vCPUs and 4GB RAM.
    - Configure security groups to allow inbound traffic on port 9000.

2. **Install Prerequisites**:
    ```bash
    sudo yum update -y  # For Amazon Linux
    sudo yum install java-17-openjdk -y
    sudo yum install wget unzip -y
    ```

3. **Download and Install SonarQube**:
    ```bash
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-<version>.zip
    unzip sonarqube-<version>.zip
    sudo mv sonarqube-<version> /opt/sonarqube
    ```

4. **Start SonarQube**:
    ```bash
    cd /opt/sonarqube/bin/linux-x86-64
    ./sonar.sh start
    ```

5. **Access SonarQube**:
    - Open a browser and navigate to `http://<EC2-Public-IP>:9000`.

### Running SonarQube as a Docker Container

1. **Install Docker**:
    - Follow the [Docker installation guide](https://docs.docker.com/get-docker/) for your operating system.

2. **Pull the SonarQube Docker Image**:
    ```bash
    docker pull sonarqube
    ```

3. **Run the SonarQube Container**:
    ```bash
    docker run -d --name sonarqube -p 9000:9000 -e SONAR_JAVA_OPTS="-Djava.version=17" sonarqube
    ```

4. **Verify the Container**:
    - Use `docker ps` to ensure the container is running.

5. **Access SonarQube**:
    - Open a browser and navigate to `http://localhost:9000`.

### Notes
- Ensure the EC2 instance or Docker host has sufficient resources.
- For production, configure a database like PostgreSQL for SonarQube.
- Refer to the [official SonarQube documentation](https://docs.sonarqube.org/latest/setup/get-started-2-minutes/) for more details.
