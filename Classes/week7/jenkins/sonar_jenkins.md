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
    **![Image](https://github.com/user-attachments/assets/ab1c7058-a1c3-4975-81c8-ee7e165d6daf)**
---
### 2. Generate Token in SonarQube

1. Log in to SonarQube.
2. Go to **My Account > Security**.
3. Under **Generate Tokens**:
    - Enter a name like `JenkinsPipelineToken`.
    - Click **Generate**.
    - Copy and securely store the token.
    ![Image](https://github.com/user-attachments/assets/3ce02050-f95e-47c4-a890-4ed33a40c004)
    ![Image](https://github.com/user-attachments/assets/358e194d-3043-4893-8f85-43998aea39e7)

---
### 3. Add SonarQube Token in Jenkins Credentials

1. Go to `Manage Jenkins` > `Manage Credentials`.
2. Choose the appropriate domain (e.g., `Global`).
3. Click **Add Credentials**.
4. Select `Kind`: **Secret text**.
5. Provide:
   - **Secret**: Paste the generated SonarQube token.
   - **ID**: `sonar-token` (use this ID in your pipeline).
   - **Description**: e.g., `SonarQube Token for Jenkins`.
   **![Image](https://github.com/user-attachments/assets/9342c2b9-d226-4a68-a46c-94beaebf1a29)**
6. Click **OK**.

> **Note**: Use this credential ID in your Jenkins pipeline to authenticate with SonarQube.

---


### 4. Install SonarQube Scanner in Jenkins

- Go to `Manage Jenkins` > `Global Tool Configuration`.
- Under **JDK**:
  - Click **Add JDK** (if required).
  **![Image](https://github.com/user-attachments/assets/46645914-fd48-4710-9644-38d7eda99f97)**
- Under **SonarQube Scanner**:
  - Click **Add SonarQube Scanner**
  - Set Name: `SonarScanner`
  - Select: `Install automatically`
  **![Image](https://github.com/user-attachments/assets/091da20d-0053-447c-8eb7-1ae5ef08e013)**

---

### 5. Configure Webhook in SonarQube

To ensure Jenkins waits for and processes the Quality Gate result:

1. In SonarQube, go to **Administration > Configuration > Webhooks**.
2. Click **Create**.
3. Set:
   - **Name**: `Jenkins`
   - **URL**: `http://<jenkins-host>:<port>/sonarqube-webhook/`  
     **![Image](https://github.com/user-attachments/assets/e8627614-4741-431e-8e1a-06c40ec731c1)**
4. Click **create**.
**![Image](https://github.com/user-attachments/assets/4d2781c7-2d5f-4636-888b-e576a77a0bb1)**


> This webhook notifies Jenkins once the analysis is complete, enabling `waitForQualityGate()`.

---

## 🧪 Jenkins Pipeline Example (Declarative)

```groovy
stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn clean verify
                        mvn sonar:sonar \
                            -Dsonar.projectKey=${DOCKER_IMAGE} \
                            -Dsonar.projectName=${DOCKER_IMAGE} \
                            -Dsonar.sources=src/main/java \
                            -Dsonar.tests=src/test/java \
                            -Dsonar.java.binaries=target/classes \
                            -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    """
                }
            }
        }

        stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: "--scan ./ --format XML --out dependency-check-report.xml", odcInstallation: 'OWASP-DC'
                dependencyCheckPublisher pattern: "**/dependency-check-report.xml"
            }
        }

        stage('Sonar Quality Gate') {
            steps {
                timeout(time: 2, unit: "MINUTES") {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Trivy File System Scan') {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }

        stage('Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh "trivy image --format table -o trivy-image-report.html $DOCKER_IMAGE:$DOCKER_TAG"
            }
        }
```
## Notes
- Replace `<sonarqube-server>` with your SonarQube server address.
- Replace `sonarqube-token-id` with the Jenkins credentials ID for your SonarQube token.
- Adjust build and SonarQube commands based on your project setup.
