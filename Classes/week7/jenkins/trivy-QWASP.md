# Trivy and OWASP Integration with Jenkins Pipeline

This guide provides steps to install Trivy and OWASP Dependency-Check, and integrate them into a Jenkins pipeline.

## Prerequisites
- Jenkins installed and running.
- Docker installed on the Jenkins server.
- Jenkins plugins: `Pipeline`, `Blue Ocean`, and `Docker Pipeline`.

---

## Step 1: Install Trivy
1. Install Trivy using Docker:
```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
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