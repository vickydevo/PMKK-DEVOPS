# 🔗 Integrating SonarQube with Jenkins

This guide explains how to integrate SonarQube with Jenkins for static code analysis and quality gate enforcement.

---

## ✅ Prerequisites

1. Install and configure **SonarQube Server**.
2. Install and run **Jenkins**.
3. **Install Required Plugins in Jenkins**:
    - Go to `Manage Jenkins` > `Plugin Manager`.
    - Install the following plugins:
        - **SonarQube Scanner**
        - **Sonar Quality Gates**
    - Restart Jenkins after plugin installation.
    ![Image](https://github.com/user-attachments/assets/95c7e4c9-2775-49d1-8fa1-f8e9a9be2074)

---

## ⚙️ Step-by-Step Integration

### 1. Configure SonarQube in Jenkins

- Navigate to `Manage Jenkins` > `Configure System`.
- Find the **SonarQube Servers** section.
- Click **Add SonarQube** and fill in:
  - **Name**: `SonarQube`
  - **Server URL**: `http://<sonarqube-server>:9000`
  - **Authentication Token**: Generate from SonarQube (see below).

---

### 2. Install SonarQube Scanner in Jenkins

- Go to `Manage Jenkins` > `Global Tool Configuration`.
- Under **JDK**:
  - Click **Add JDK** (if required).
  ![Image](https://github.com/user-attachments/assets/46645914-fd48-4710-9644-38d7eda99f97)
- Under **SonarQube Scanner**:
  - Click **Add SonarQube Scanner**
  - Set Name: `SonarScanner`
  - Select: `Install automatically`
  ![Image](https://github.com/user-attachments/assets/091da20d-0053-447c-8eb7-1ae5ef08e013)

---

### 3. Generate Token in SonarQube

1. Log in to SonarQube.
2. Go to **My Account > Security**.
3. Under **Generate Tokens**:
    - Enter a name like `JenkinsPipelineToken`.
    - Click **Generate**.
    - Copy and securely store the token.
    ![Image](https://github.com/user-attachments/assets/3ce02050-f95e-47c4-a890-4ed33a40c004)
    ![Image](https://github.com/user-attachments/assets/358e194d-3043-4893-8f85-43998aea39e7)

---

### 4. Add SonarQube Token in Jenkins Credentials

1. Go to `Manage Jenkins` > `Manage Credentials`.
2. Choose the appropriate domain (e.g., `Global`).
3. Click **Add Credentials**.
4. Select `Kind`: **Secret text**.
5. Provide:
   - **Secret**: Paste the generated SonarQube token.
   - **ID**: `sonar-token` (use this ID in your pipeline).
   - **Description**: e.g., `SonarQube Token for Jenkins`.
6. Click **OK**.

> **Note**: Use this credential ID in your Jenkins pipeline to authenticate with SonarQube.

---

### 5. Configure Webhook in SonarQube

To ensure Jenkins waits for and processes the Quality Gate result:

1. In SonarQube, go to **Administration > Configuration > Webhooks**.
2. Click **Create**.
3. Set:
   - **Name**: `Jenkins`
   - **URL**: `http://<jenkins-host>:<port>/sonarqube-webhook/`  
     _(Replace with actual Jenkins server address)_
4. Click **Save**.

> This webhook notifies Jenkins once the analysis is complete, enabling `waitForQualityGate()`.

---

## 🧪 Jenkins Pipeline Example (Declarative)

```groovy
pipeline {
    agent any

    tools {
        jdk 'jdk-17'
        sonarQubeScanner 'SonarScanner'
    }

    environment {
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your/project.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner -Dsonar.projectKey=your-key -Dsonar.sources=. -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
```

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
