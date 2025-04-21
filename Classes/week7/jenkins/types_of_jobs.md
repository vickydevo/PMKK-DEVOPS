# Jenkins: Types of Jobs

This document provides an overview of the types of jobs in Jenkins, along with examples and configurations.

---

## Jenkins CI: Continuous Integration

Jenkins is a powerful tool for automating tasks such as testing, building, and deploying code. It integrates with version control systems like GitHub and Git to streamline the CI/CD pipeline.

### Typical CI/CD Pipeline
1. **Source Code Management (SCM)**: Integrate with GitHub or Git.
2. **Test**: Run automated tests.
3. **Build**: Compile the code.
4. **Continuous Deployment (CD)**: Deploy the application.

---

## Types of Jobs in Jenkins

### 1. Freestyle Job
Freestyle jobs are the most basic type of Jenkins job. They allow you to configure and execute simple tasks.

#### Example: Parameterized Job
1. **Parameters**:
    - String Parameter: `Project`
    - Default Value: `java-spring`
    - Password Parameter: `Password`

2. **Shell Script**:
    ```bash
    #!/bin/bash
    if [ $Project == java-spring ]; then
         echo "This is a Java-based project"
    else
         echo "Not a Java project"
    fi
    ```

3. **Docker Commands**:
    ```bash
    export DOCKER_USERNAME=your_username
    export DOCKER_PASSWORD=your_password

    echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

    docker build -t $ImageName:$Tag .
    docker tag $ImageName:$Tag $dockerhub_username/$ImageName:$Tag
    docker tag $ImageName:$Tag $dockerhub_username/$ImageName:latest
    docker push $dockerhub_username/$ImageName:$Tag
    docker push $dockerhub_username/$ImageName:latest
    ```

#### Trigger Build Remotely
- Add an authentication token.
- Example Cron Expression:
  ```
  10 4 * * *  # At 04:10 every day
  ```

---

### 2. Template Mode Job
Template mode jobs are used for managing upstream and downstream jobs.

#### Example Workflow:
- **Job 1**: Add Git repository.
- **Job 2**: Copy Git files to Job 2.
- **Job 3**: Perform downstream tasks.

---

### 3. Maven Java Application
Maven jobs are used for Java projects that require Maven for build automation.

#### Configuration:
1. Install the Maven plugin in Jenkins.
2. Specify the Maven home path or enable automatic installation.

#### Maven Lifecycle Goals:
- `validate` → `compile` → `test` → `package` → `integration-test` → `verify` → `install` → `deploy`
- Example:
  ```bash
  clean validate verify test compile package install
  ```

---

### 4. Pipeline Job
Pipeline jobs allow you to define complex workflows using code. There are two types of pipeline jobs:
1. **Declarative Pipeline**
2. **Scripted Pipeline**

#### Declarative Pipeline Example:
```groovy
pipeline {
     agent any
     stages {
          stage('SCM') {
                steps {
                     sh "echo 'SCM Stage'"
                }
          }
          stage('TEST') {
                steps {
                     sh "echo 'Test Stage'"
                }
          }
          stage('BUILD') {
                steps {
                     sh "echo 'Build Stage'"
                }
          }
          stage('DEPLOY') {
                steps {
                     sh "echo 'Deploy Stage'"
                }
          }
     }
}
```

#### Scripted Pipeline Example:
```groovy
node {
     stage('SCM') {
          sh "echo 'SCM Stage'"
     }
     stage('TEST') {
          sh "echo 'Test Stage'"
     }
     stage('BUILD') {
          sh "echo 'Build Stage'"
     }
     stage('DEPLOY') {
          sh "echo 'Deploy Stage'"
     }
}
```

---

## Jenkins Build Trigger: Automatic
1. **Step 1**: In Jenkins, navigate to the job and select "Trigger Build" → "Git SCM Poll".
2. **Step 2**: In GitHub, go to the repository settings → Webhooks → Add webhook.
    - Use the Jenkins URL with `/github-webhook/` at the end.
    - Example: `http://your-jenkins-url/github-webhook/`

---

## Additional Resources
- [Jenkins Official Documentation](https://www.jenkins.io/doc/)
- [YouTube Tutorial](https://www.youtube.com/watch?v=ibAOrGiRRxU&t=297s)
- [Crontab Guru](https://crontab.guru)

--- 

This document provides a structured overview of Jenkins job types and configurations to help you get started with CI/CD pipelines.
