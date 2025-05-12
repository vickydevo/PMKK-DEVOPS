# SonarQube

## What is SonarQube?

SonarQube is an open-source platform for continuous inspection of code quality. It detects bugs, vulnerabilities, and code smells, ensuring maintainability and reliability. It supports over 25 programming languages, including Java, Python, JavaScript, C#, and more.

## Why is it Mainly Used for Java?

- Java's popularity in enterprise applications with complex codebases.
- Robust support for Java-specific rules and plugins.
- Seamless integration with Java build tools like Maven and Gradle.

## Default Port

The default port for accessing SonarQube is **9000**.

## Code Quality Checks in SonarQube

SonarQube performs the following checks:

1. **Bugs**: Logical errors or flaws in the code.
2. **Vulnerabilities**: Security issues exploitable by attackers.
3. **Code Smells**: Maintainability issues or bad coding practices.
4. **Code Coverage**: Measures the percentage of code executed during testing.
5. **Duplications**: Detects duplicate code blocks.
6. **Complexity Analysis**: Identifies overly complex code needing refactoring.

These checks ensure reliable, secure, and maintainable code, integrating seamlessly into CI/CD pipelines.

## What is Code Coverage?

Code coverage measures the percentage of source code executed during testing, identifying untested parts of the codebase.

### Types of Code Coverage

1. **Statement Coverage**: Ensures each statement is executed.
2. **Branch Coverage**: Tests all possible branches (e.g., if-else).
3. **Function Coverage**: Confirms every function is called.
4. **Line Coverage**: Measures executed lines of code.

### Importance

- Identifies testing gaps.
- Improves reliability and maintainability.
- Reduces undetected bugs in production.

### Tools

- **JaCoCo** (Java)
- **Coverage.py** (Python)
- **Istanbul** (JavaScript)
- **Cobertura** (Java)
- **gcov** (C/C++)
- **SonarQube** (multi-language support)

## SonarQube Versions

1. **Community Edition** (Free): Basic features for small teams.
2. **Developer Edition** (Paid): Advanced features for developers.
3. **Enterprise Edition** (Paid): Scalable for large organizations.
4. **Data Center Edition** (Paid): High availability for enterprises.

For details, refer to the [SonarQube Editions Comparison](https://www.sonarsource.com/plans-and-pricing/).

## Installation Setup of SonarQube

### Installing on EC2 (Amazon Linux 2023/Ubuntu)

#### Prerequisites

- EC2 instance with 2 vCPUs and 4GB RAM.
- Security group allowing inbound traffic on port **9000**.

### Running SonarQube as a Docker Container

1. **Install Docker**: Follow the [Docker installation guide](https://docs.docker.com/get-docker/).
    ```bash
        sudo apt update -y && sudo apt install docker.io -y
    ```
2. **Pull Image**:
    ```bash
    docker pull sonarqube:lts-community
    ```
3. **Run Container**:
    
    ```bash
    docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community
    ```
    or
    ```bash
    docker run -d --name sonarqube -p 9000:9000 -e SONAR_JAVA_OPTS="-Djava.version=17" sonarqube:lts-community
    ```
    ![Image](https://github.com/user-attachments/assets/3984f69f-84c2-486f-ab10-6a61e73d5fd4)
4. **Verify**: Use `docker ps` to confirm the container is running.
5. **Access**: Navigate to `http://<instance-public-ip>:9000`.

### Logging into SonarQube

1. **Default Credentials**:
    - Username: `admin`
    - Password: `admin`
    ![Image](https://github.com/user-attachments/assets/6462c55b-b117-4387-8d97-44439ddeef88)
2. **Change Password**: Prompted on first login.
3. **Dashboard**:
    ![Image](https://github.com/user-attachments/assets/a28caa7a-b75c-46dc-9522-33a69fbe6952)

## Quality Profile in SonarQube

A **Quality Profile** defines rules for code analysis, ensuring adherence to standards.

### Features

1. **Customizable Rules**: Enable/disable rules as needed.
2. **Language-Specific**: Profiles for each language.
3. **Default Profiles**: Predefined profiles for quick use.
4. **Inheritance**: Share rules across projects.

### Importance

- Ensures consistent code quality.
- Enforces coding standards.
- Detects issues early.

### Management

- Navigate to **Quality Profiles** in the dashboard.
- Create, edit, or delete profiles.
- Assign profiles to projects.

Refer to the [Quality Profiles Documentation](https://docs.sonarsource.com/latest/analysis/quality-profiles/).

## Quality Gate in SonarQube

A **Quality Gate** is a set of conditions a project must meet for acceptable quality.

### Features

1. **Customizable Conditions**: Define metrics like code coverage, bugs, and duplications.
2. **Pass/Fail Criteria**: Projects pass if all conditions are met.
3. **Default Gate**: "Sonar Way" for basic quality checks.
4. **CI/CD Integration**: Blocks builds if the gate fails.

### Importance

- Ensures consistent quality.
- Detects issues early.
- Reduces production risks.

### Management

- Navigate to **Quality Gates** in the dashboard.
- Create, edit, or delete gates.
- Assign gates to projects.

Refer to the [Quality Gates Documentation](https://docs.sonarsource.com/latest/analysis/quality-gates/).
