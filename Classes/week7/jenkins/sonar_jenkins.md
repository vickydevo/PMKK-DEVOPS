# Integrating SonarQube with Jenkins

## Prerequisites
1. Install and configure SonarQube server.
2. Install Jenkins and ensure it is running.
3. Install the "SonarQube Scanner" plugin in Jenkins.
  **![Image](https://github.com/user-attachments/assets/5dee8798-4540-47e6-9d54-15595c0fe103)**

## Steps to Integrate SonarQube with Jenkins
1. **Configure SonarQube in Jenkins**:
    - Go to `Manage Jenkins` > `Configure System`.
    - Scroll to the "SonarQube Servers" section.
    - Click `Add SonarQube` and provide:
      - Name (e.g., `SonarQube`).
      - Server URL (e.g., `http://<sonarqube-server>:9000`).
      - Authentication Token (generate from SonarQube under `My Account > Security`).

2. **Install SonarQube Scanner**:
    - Go to `Manage Jenkins` > `Global Tool Configuration`.
    - Scroll to "jdk" and "SonarQube Scanner" .
    - Click `Add jdk` and provide:
      **![Image](https://github.com/user-attachments/assets/46645914-fd48-4710-9644-38d7eda99f97)**
    - Click `Add SonarQube Scanner` and provide:
      - Name (e.g., `SonarScanner`).
      - Installation method (e.g., `Install automatically`).
      **![Image](https://github.com/user-attachments/assets/091da20d-0053-447c-8eb7-1ae5ef08e013)**

3. **Create a Jenkins Pipeline**:
    - Create a new pipeline job in Jenkins.
    - Add the SonarQube analysis steps in the pipeline script.

## Sample Pipeline Script
```groovy
pipeline {
     agent any
     tools {
          // Use the SonarQube Scanner tool configured in Jenkins
          sonarQube 'Sonar-scanner'
     }
     environment {
          // SonarQube environment variables
          SONAR_HOST_URL = 'http://ec2-18-215-164-93.compute-1.amazonaws.com:9000'
          SONAR_AUTH_TOKEN = credentials('squ_71b371877b164d811d4441d58b34a507d806a31a')
     }
     stages {
          stage('Checkout Code') {
                steps {
                     checkout scm
                }
          }
          stage('Build') {
                steps {
                     sh './gradlew build' // Replace with your build command
                }
          }
          stage('SonarQube Analysis') {
                steps {
                     withSonarQubeEnv('SonarQube') {
                          sh './gradlew sonarqube' // Replace with your SonarQube command
                     }
                }
          }
          stage('Quality Gate') {
                steps {
                     script {
                          def qualityGate = waitForQualityGate()
                          if (qualityGate.status != 'OK') {
                                error "Pipeline aborted due to quality gate failure: ${qualityGate.status}"
                          }
                     }
                }
          }
     }
}
```

## Notes
- Replace `<sonarqube-server>` with your SonarQube server address.
- Replace `sonarqube-token-id` with the Jenkins credentials ID for your SonarQube token.
- Adjust build and SonarQube commands based on your project setup.
