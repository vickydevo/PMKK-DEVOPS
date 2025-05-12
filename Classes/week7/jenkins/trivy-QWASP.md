# Trivy and OWASP Integration with Jenkins Pipeline

This guide provides steps to install Trivy and OWASP Dependency-Check, and integrate them into a Jenkins pipeline.

## Prerequisites
- Jenkins installed and running.
- Docker installed on the Jenkins server.
---


---

Would you like this extended with **installation steps**, **CI integration**, or **HTML report generation** options as well?
```



## Step 1: Install Trivy
1. Install Trivy using Docker:
```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
```
```bash

trivy --version 
```
**![Image](https://github.com/user-attachments/assets/a683d3d9-ac96-4bca-8a1b-d42bc315fb99)**
---

# 🔍 Trivy Usage Examples
Trivy is a comprehensive and easy-to-use vulnerability scanner for containers, file systems, repositories, and configurations.

## 🔹 1. Scan a Docker Image

```bash
trivy image nginx:latest
```  
**![Image](https://github.com/user-attachments/assets/b4c65e00-080f-4af6-b19f-dc721e74787f)**

**![Image](https://github.com/user-attachments/assets/0b0840b5-93ee-4706-8abb-26e72a333413)**
---

## 🔹 2. Scan a Local File System

```bash
trivy fs .
```

---

## 🔹 3. Scan a Git Repository

```bash
trivy repo https://github.com/your/project
```

---

## 🔹 4. Scan Configuration Files (Kubernetes, Terraform, etc.)

```bash
trivy config .
```

---

## 🔹 5. Scan for Secrets in Code

```bash
trivy fs --scanners secret .
```

---

## 🔹 6. Filter by Severity

```bash
trivy image --severity CRITICAL,HIGH nginx:latest
```

---

## 🔹 7. Export Results in JSON Format

```bash
trivy image --format json -o result.json nginx:latest
```

---

## 📘 Resources

* [Trivy GitHub Repository](https://github.com/aquasecurity/trivy)
* [Official Documentation](https://aquasecurity.github.io/trivy/)

```


## Step 2: Install OWASP Dependency-Check and Docker Plugin in Jenkins

1. Open Jenkins in your web browser.
2. Navigate to **Manage Jenkins** > **Manage Plugins**.
3. Go to the **Available** tab and search for the following plugins:
    - `OWASP Dependency-Check`
    - `Docker Pipeline`
4. Select both plugins and click **Install without restart**.
5. Wait for the installation to complete, then verify that the plugins are listed under the **Installed** tab.

**![Image](https://github.com/user-attachments/assets/38572f7a-35a0-4cb9-9a58-4d3a2a381ddb)**
--- 
## Step 3: Configure OWASP Dependency-Check in Jenkins

1. Open Jenkins in your web browser.
2. Navigate to **Manage Jenkins** > **Global Tool Configuration**.
3. Scroll down to the **OWASP Dependency-Check** section.
4. Click **Add Dependency-Check** and provide a name (e.g., `OWASP-DC`).
5. Configure the installation directory or let Jenkins install it automatically.
**![Image](https://github.com/user-attachments/assets/b13551c6-0762-48fa-b24c-8672e0e8b348)**
6. Save the configuration.

## Step 4: Add Trivy and OWASP Dependency-Check to Jenkins Pipeline

1. Edit your Jenkins pipeline script to include Trivy and OWASP Dependency-Check steps:
```groovy
pipeline {
    agent any
    stages {
        stage('Trivy Scan') {
            steps {
                sh 'trivy image --severity HIGH,CRITICAL your-docker-image'
            }
        }
        stage('OWASP Dependency-Check') {
            steps {
                dependencyCheck additionalArguments: '--format XML --out dependency-check-report.xml', odcInstallation: 'OWASP-DC'
            }
        }
    }
}
```

2. Save the pipeline script and run the build.
3. Review the scan results in the Jenkins console output or generated reports.