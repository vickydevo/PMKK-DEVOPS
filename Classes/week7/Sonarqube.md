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

## Code Quality Checks in SonarQube

SonarQube performs comprehensive code quality checks, including:

1. **Bugs**: Identifies logical errors or flaws in the code that could lead to incorrect behavior.
2. **Vulnerabilities**: Detects security issues that could be exploited by attackers.
3. **Code Smells**: Highlights maintainability issues or bad coding practices that could make the code harder to understand or modify.
4. **Code Coverage**: Measures the percentage of code executed during testing, helping identify untested parts of the codebase. This ensures better test coverage and higher code quality.
5. **Duplications**: Detects duplicate code blocks, which can lead to unnecessary maintenance overhead.
6. **Complexity Analysis**: Evaluates the complexity of methods, classes, and files to identify overly complex code that may need refactoring.

These checks help ensure that the code is reliable, secure, maintainable, and efficient. SonarQube integrates seamlessly into CI/CD pipelines, providing continuous feedback to developers.


## What is Code Coverage?

Code coverage is a software metric used to measure the percentage of source code executed during testing. It helps identify untested parts of a codebase, ensuring better test coverage and higher code quality.

### Types of Code Coverage
1. **Statement Coverage**: Verifies that each statement in the code has been executed.
2. **Branch Coverage**: Ensures that all possible branches (e.g., if-else conditions) are tested.
3. **Function Coverage**: Confirms that every function or method has been called.
4. **Line Coverage**: Measures the number of lines executed during testing.

### Importance of Code Coverage
- Identifies gaps in testing.
- Improves code reliability and maintainability.
- Reduces the risk of undetected bugs in production.

### Tools for Code Coverage
Some popular tools for measuring code coverage include:
- **JaCoCo** (Java)
- **Coverage.py** (Python)
- **Istanbul** (JavaScript)
- **Cobertura** (Java)
- **gcov** (C/C++)
- **SonarQube** (Supports multiple languages)

Code coverage is often integrated into CI/CD pipelines to ensure consistent quality checks.

## Types of SonarQube Versions

SonarQube is available in the following versions to cater to different needs:

1. **Community Edition** (Free):
    - Open-source and free to use.
    - Suitable for small teams and personal projects.
    - Provides basic code quality and security analysis.

2. **Developer Edition** (Paid):
    - Includes all features of the Community Edition.
    - Adds advanced features like branch analysis and pull request decoration.
    - Supports additional languages and enhanced security rules.

3. **Enterprise Edition** (Paid):
    - Includes all features of the Developer Edition.
    - Designed for large organizations.
    - Provides portfolio management, project governance, and advanced reporting.

4. **Data Center Edition** (Paid):
    - Includes all features of the Enterprise Edition.
    - Offers high availability and scalability for large-scale deployments.
    - Suitable for organizations requiring robust performance and reliability.

Each edition is tailored to meet specific requirements, from individual developers to enterprise-level teams. For more details, refer to the [SonarQube Editions Comparison](https://www.sonarsource.com/plans-and-pricing/).


## Installation Setup of SonarQube

### Installing SonarQube on an EC2 Instance (Amazon Linux 2023 and Ubuntu Latest)

#### Prerequisites
- An EC2 instance with at least 2 vCPUs and 4GB RAM.
- Security group configured to allow inbound traffic on port **9000**.

#### Steps for Amazon Linux 2023

1. **Update the System**:
    ```bash
    sudo yum update -y
    ```

2. **Install Java**:
    ```bash
    sudo amazon-linux-extras enable java-openjdk17
    sudo yum install java-17-openjdk -y
    ```

3. **Install Required Tools**:
    ```bash
    sudo yum install wget unzip -y
    ```

4. **Download and Install SonarQube**:
    ```bash
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-<version>.zip
    unzip sonarqube-<version>.zip
    sudo mv sonarqube-<version> /opt/sonarqube
    ```

5. **Start SonarQube**:
    ```bash
    cd /opt/sonarqube/bin/linux-x86-64
    ./sonar.sh start
    ```

6. **Access SonarQube**:
    - Open a browser and navigate to `http://<EC2-Public-IP>:9000`.

#### Steps for Ubuntu Latest

1. **Update the System**:
    ```bash
    sudo apt update && sudo apt upgrade -y
    ```

2. **Install Java**:
    ```bash
    sudo apt install openjdk-17-jdk -y
    ```

3. **Install Required Tools**:
    ```bash
    sudo apt install wget unzip -y
    ```

4. **Download and Install SonarQube**:
    ```bash
    wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-<version>.zip
    unzip sonarqube-<version>.zip
    sudo mv sonarqube-<version> /opt/sonarqube
    ```

5. **Start SonarQube**:
    ```bash
    cd /opt/sonarqube/bin/linux-x86-64
    ./sonar.sh start
    ```

6. **Access SonarQube**:
    - Open a browser and navigate to `http://<EC2-Public-IP>:9000`.

#### Notes
- Replace `<version>` with the desired SonarQube version (e.g., `sonarqube-9.9.1.69595`).
- Ensure the EC2 instance has sufficient resources for optimal performance.
- For additional configuration, refer to the [SonarQube documentation](https://docs.sonarsource.com/latest/setup/get-started-2-minutes/).
- Use the **Community Edition** for open-source and free usage.
- Ensure port **9000** is open in the security group for inbound traffic.
- SonarQube requires a database for production use; configure it as needed.
- Run SonarQube as a service for persistent usage.


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
    - Open a browser and navigate t### Installing SonarQube on an EC2 Instanceo `http://localhost:9000`.

### Notes
- Ensure the EC2 instance or Docker host has sufficient resources.
- Refer to the [official SonarQube documentation](https://docs.sonarsource.com/latest/setup/get-started-2-minutes/) for more details.
