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
  3.  ### Generate a Token in SonarQube
    1. Log in to your SonarQube server.
    2. Navigate to your profile by clicking on your avatar in the top-right corner and selecting **My Account**.
    3. Go to the **Security** tab.
    4. Under the **Generate Tokens** section:
        - Enter a name for the token (e.g., `JenkinsPipelineToken`).
        **![Image](https://github.com/user-attachments/assets/3ce02050-f95e-47c4-a890-4ed33a40c004)**
        - Click the **Generate** button.
    5. Copy the generated token and save it securely. You will not be able to view it again.
      **![Image](https://github.com/user-attachments/assets/358e194d-3043-4893-8f85-43998aea39e7)**

    **Note**: Use this token in your Jenkins pipeline to authenticate with SonarQube.
### Configure Token in Jenkins Credentials as Secret Text
1. Go to `Manage Jenkins` > `Manage Credentials`.
2. Select the appropriate scope (e.g., `Global` or a specific folder).
3. Click on `Add Credentials`.
4. In the `Kind` dropdown, select `Secret text`.
5. Fill in the fields:
    - **Secret**: Paste the token generated from SonarQube.
    - **ID**: Enter a unique identifier (e.g., `sonar-token`).
    - **Description**: Provide a meaningful description (e.g., `SonarQube Token for Jenkins`).
6. Click `OK` to save the credentials.

**Note**: Use the `ID` in your pipeline script to reference the token.

. **Create a Jenkins Pipeline**:
    - Create a new pipeline job in Jenkins.
    - Add the SonarQube analysis steps in the pipeline script.

## Sample Pipeline Script
```groovy
pipeline {
    agent any //{
    //     label 'sai'
    //     // docker {
    //     //     image 'yourdockerhubusername/maven-docker:latest'  // Replace with actual image
    //     //     args '-v /var/run/docker.sock:/var/run/docker.sock'
    //     // }
    // }

    tools {
        git 'git2'
        maven 'm3'
        jdk 'jdk17'
        
    }

    parameters {
        string(name: 'image', defaultValue: 'spring-boot', description: 'Enter docker image name')
        string(name: 'tag', defaultValue: 'v1', description: 'Enter docker image TAG')
    }

    environment {
        DOCKER_IMAGE = "${params.image}"
        DOCKER_TAG = "${params.tag}"
        // SONAR_HOST_URL = 'http://ec2-18-215-164-93.compute-1.amazonaws.com:9000'
        // SONAR_AUTH_TOKEN = credentials('squ_71b371877b164d811d4441d58b34a507d806a31a')
    }

    stages {
        stage('SCM CHECKOUT') {
            steps {
                git branch: 'main', url: 'https://github.com/vickydevo/springboot-hello.git'
            }
        }

        stage('SonarQube Analysis') {
    steps {
        withCredentials([string(credentialsId: 'sonar-token', variable: 'sonar_token')]) {
            sh """
                mvn clean verify
                mvn sonar:sonar \
                    -Dsonar.projectKey=${DOCKER_IMAGE} \
                    -Dsonar.projectName=${DOCKER_IMAGE} \
                    -Dsonar.sources=src/main/java \
                    -Dsonar.tests=src/test/java \
                    -Dsonar.java.binaries=target/classes \
                    -Dsonar.host.url=http://18.215.164.93:9000 \
                    -Dsonar.token=${sonar_token} \
                    -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
            """
        }
    }
}

        // stage('Docker Image') {
        //     steps {
        //         sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
        //     }
        // }

        // stage('DockerHub push') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'docker_cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
        //             sh '''
        //                 echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
        //                 docker tag $DOCKER_IMAGE:$DOCKER_TAG $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG
        //                 docker push $DOCKER_USER/$DOCKER_IMAGE:$DOCKER_TAG
        //             '''
        //         }
        //     }
        // }
    }
}

```

## Notes
- Replace `<sonarqube-server>` with your SonarQube server address.
- Replace `sonarqube-token-id` with the Jenkins credentials ID for your SonarQube token.
- Adjust build and SonarQube commands based on your project setup.
