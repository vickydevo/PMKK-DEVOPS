# SonarQube

## What is SonarQube?
SonarQube is an open-source platform for continuous inspection of code quality. It performs automatic reviews of code to detect bugs, vulnerabilities, and code smells, ensuring maintainability and reliability.

SonarQube supports over 25 programming languages, including examples such as Java, Python, JavaScript, C#, C/C++, PHP, Ruby, Kotlin, Go, Swift.

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



### Running SonarQube as a Docker Container

1. **Install Docker**:
    - Follow the [Docker installation guide](https://docs.docker.com/get-docker/) for your operating system.

2. **Pull the SonarQube Docker Image**:
For the official SonarQube Docker image, refer to the [SonarQube Docker Hub page](https://hub.docker.com/_/sonarqube).

    ```bash
    docker pull sonarqube:lts-community 
    ```

3. **Run the SonarQube Container**:
    ```bash
    docker run --name sonarqube-custom -p 9000:9000 sonarqube:community
     ```
    or 
    ```bash
    docker run -d --name sonarqube -p 9000:9000 -e SONAR_JAVA_OPTS="-Djava.version=17" sonarqube:lts-community
    ```
    **![Image](https://github.com/user-attachments/assets/3984f69f-84c2-486f-ab10-6a61e73d5fd4)** 

4. **Verify the Container**:
    - Use `docker ps` to ensure the container is running.

5. **Access SonarQube**:
    - Open a browser and navigate t### Installing SonarQube on an EC2 Instanceo `http://instance-public_ip:9000`.
    ### Logging into SonarQube

    After accessing `http://<EC2-Public-IP>:9000` in your browser, follow these steps to log in:

    1. **Default Login Page**:
        - The SonarQube login page will open.

    2. **Default Credentials**:
        - Username: `admin`
        - Password: `admin`
      ***![Image](https://github.com/user-attachments/assets/6462c55b-b117-4387-8d97-44439ddeef88)***

    3. **Change Password**:
        - Upon first login, you will be prompted to change the default password for security purposes.

    4. **Dashboard Access**:
        - After changing the password, you will be redirected to the SonarQube dashboard.
        **![Image](https://github.com/user-attachments/assets/a28caa7a-b75c-46dc-9522-33a69fbe6952)**
   

    ## What is a Quality Profile in SonarQube?

    A **Quality Profile** in SonarQube is a set of rules that defines how the code is analyzed for quality and security. It acts as a blueprint for code analysis, ensuring that the code adheres to specific standards and best practices.

    ### Key Features of Quality Profiles:
    1. **Customizable Rules**:
        - Users can enable or disable specific rules based on project requirements.
        - Rules can be tailored to enforce coding standards, detect vulnerabilities, and identify code smells.

    2. **Language-Specific**:
        - Each programming language has its own Quality Profile.
        - Multiple profiles can exist for the same language, catering to different project needs.

    3. **Default Profiles**:
        - SonarQube provides default Quality Profiles for each language.
        - These profiles can be used as-is or customized further.

    4. **Inheritance**:
        - Quality Profiles can inherit rules from other profiles, allowing for efficient management of shared rules across projects.

    ### Importance of Quality Profiles:
    - Ensures consistent code quality across teams and projects.
    - Helps enforce organizational coding standards.
    - Facilitates early detection of bugs, vulnerabilities, and maintainability issues.

    ### Managing Quality Profiles:
    - Navigate to the **Quality Profiles** section in the SonarQube dashboard.
    - Create, edit, or delete profiles as needed.
    - Assign profiles to specific projects for tailored analysis.

    For more details, refer to the [SonarQube Quality Profiles Documentation](https://docs.sonarsource.com/latest/analysis/quality-profiles/).

    ## What is a Quality Gate in SonarQube?

    A **Quality Gate** in SonarQube is a set of conditions that a project must meet to be considered of acceptable quality. It acts as a checkpoint in the software development lifecycle, ensuring that code meets predefined quality standards before it is released or merged.

    ### Key Features of Quality Gates:
    1. **Customizable Conditions**:
        - Users can define specific conditions based on metrics such as code coverage, bugs, vulnerabilities, code smells, and duplications.
        - Conditions can be tailored to meet project or organizational requirements.

    2. **Pass/Fail Criteria**:
        - A project passes the Quality Gate if it meets all the defined conditions.
        - If any condition is not met, the Quality Gate fails, signaling the need for corrective action.

    3. **Default Quality Gate**:
        - SonarQube provides a default Quality Gate called "Sonar Way," which includes basic conditions for code quality and security.
        - This can be used as-is or customized further.

    4. **Integration with CI/CD Pipelines**:
        - Quality Gates can be integrated into CI/CD pipelines to enforce quality checks automatically.
        - Builds can be blocked if the Quality Gate fails, preventing poor-quality code from being deployed.

    ### Importance of Quality Gates:
    - Ensures consistent code quality across projects.
    - Helps detect and address issues early in the development process.
    - Reduces the risk of introducing bugs or vulnerabilities into production.
    - Encourages developers to follow best practices and coding standards.

    ### Managing Quality Gates:
    - Navigate to the **Quality Gates** section in the SonarQube dashboard.
    - Create, edit, or delete Quality Gates as needed.
    - Assign Quality Gates to specific projects for tailored quality checks.

    For more details, refer to the [SonarQube Quality Gates Documentation](https://docs.sonarsource.com/latest/analysis/quality-gates/).

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
