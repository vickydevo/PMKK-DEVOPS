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
#### Parameterized Freestyle Job Example

A parameterized freestyle job allows you to pass parameters to your build. Here's how to configure it:

1. **Create the Job**:
     - Go to the Jenkins Dashboard.
     - Click "New Item."
     - Enter a name like `Say-Hello`.
     - Choose "Freestyle project," then click OK.

2. **Add Parameters**:
     - Scroll to "This project is parameterized" and check the box.
     - Click "Add Parameter" → choose "String Parameter."
     - Enter the following details:
       - **Name**: `USERNAME`
       - **Default Value**: `DevOpsLearner`
       - **Description**: Enter your name.

3. **Add Build Step**:
     - Scroll to "Build" → Click "Add build step" → "Execute shell."
     - Paste the following shell script:
       ```bash
       #!/bin/bash
       echo "👋 Hello, $USERNAME!"
       if [ "$USERNAME" == "Batman" ]; then
               echo "🦇 Welcome to the Batcave!"
       else
               echo "Have a great DevOps day, $USERNAME! 🚀"
       fi
       ```

4. **Save & Run**:
     - Click "Save."
     - Click "Build with Parameters."
     - Enter a name (e.g., `Batman`) and click "Build."
     - Check the Console Output to see the result.

This setup demonstrates how to create a parameterized freestyle job in Jenkins with dynamic user input.
#### Parameterized Freestyle Job with Boolean Parameter Example

A parameterized freestyle job can also include boolean parameters to toggle specific behaviors in your build. Here's how to configure it:

1. **Create the Job**:
     - Go to the Jenkins Dashboard.
     - Click "New Item."
     - Enter a name like `Deploy-App`.
     - Choose "Freestyle project," then click OK.

2. **Add Parameters**:
     - Scroll to "This project is parameterized" and check the box.
     - Click "Add Parameter" → choose "Boolean Parameter."
     - Enter the following details:
       - **Name**: `DEPLOY_TO_PROD`
       - **Default Value**: `false`
       - **Description**: Check this box to deploy to the production environment.

3. **Add Build Step**:
     - Scroll to "Build" → Click "Add build step" → "Execute shell."
     - Paste the following shell script:
       ```bash
       #!/bin/bash
       if [ "$DEPLOY_TO_PROD" = "true" ]; then
               echo "🚀 Deploying to Production..."
               # Add your production deployment commands here
       else
               echo "⚙️ Deploying to Staging..."
               # Add your staging deployment commands here
       fi
       ```

4. **Save & Run**:
     - Click "Save."
     - Click "Build with Parameters."
     - Toggle the `DEPLOY_TO_PROD` checkbox as needed and click "Build."
     - Check the Console Output to see the deployment environment.

This setup demonstrates how to use a boolean parameter to control deployment environments dynamically in Jenkins.
    
### 2. Maven Java Application
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
### 3. Template Job (Upstream/Downstream Jobs)

Template jobs in Jenkins, often referred to as upstream or downstream jobs, allow you to create dependencies between jobs. This setup is useful when you want to trigger one job after another or share configurations across multiple jobs.

#### Upstream and Downstream Job Example

1. **Scenario**:
     - You have a project with two stages: `Build` and `Deploy`.
     - The `Build` job should trigger the `Deploy` job automatically after successful execution.

2. **Steps to Configure**:
     - **Create the Upstream Job (`Build`)**:
       1. Go to the Jenkins Dashboard.
       2. Click "New Item" → Enter a name like `Build-Job` → Choose "Freestyle project" → Click OK.
       3. Add your build steps (e.g., compile code, run tests).
       4. Save the job.

     - **Create the Downstream Job (`Deploy`)**:
       1. Go to the Jenkins Dashboard.
       2. Click "New Item" → Enter a name like `Deploy-Job` → Choose "Freestyle project" → Click OK.
       3. Add your deployment steps (e.g., deploy to staging or production).
       4. Save the job.

     - **Link the Jobs**:
       1. Open the `Build-Job` configuration.
       2. Scroll to the "Post-build Actions" section.
       3. Select "Build other projects" → Enter `Deploy-Job` in the "Projects to build" field.
       4. Save the configuration.

3. **Run the Pipeline**:
     - Trigger the `Build-Job`.
     - Once the `Build-Job` completes successfully, the `Deploy-Job` will start automatically.

#### Real-Time Example: CI/CD Pipeline
- **Upstream Job**: A `Build` job compiles the code and runs unit tests.
- **Downstream Job**: A `Deploy` job deploys the application to a staging or production environment.

#### Advanced Use Case: Parameterized Trigger
You can pass parameters from the upstream job to the downstream job:
1. Install the "Parameterized Trigger Plugin."
2. In the upstream job, configure "Post-build Actions" → "Trigger parameterized build on other projects."
3. Pass parameters like `BUILD_VERSION` or `DEPLOY_ENV` to the downstream job.

This setup is ideal for creating dynamic and reusable pipelines in Jenkins.
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
