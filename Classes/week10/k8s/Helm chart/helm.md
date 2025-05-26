# Helm Charts

## What is a Helm Chart?

A **Helm Chart** is a package format for Kubernetes applications. It contains all the resource definitions required to run an application, tool, or service inside a Kubernetes cluster. Helm charts help you define, install, and upgrade even the most complex Kubernetes applications.

## Helm Chart Life Cycle

1. **Create**: Develop a new chart using `helm create`.
2. **Package**: Bundle the chart files into a `.tgz` archive.
3. **Publish**: Upload the chart to a Helm repository.
4. **Install**: Deploy the chart to a Kubernetes cluster using `helm install`.
5. **Upgrade**: Update the release with a new chart version using `helm upgrade`.
6. **Rollback**: Revert to a previous release if needed.
7. **Uninstall**: Remove the release from the cluster using `helm uninstall`.

## Kubernetes Manifests vs Helm Charts

| Feature                | Kubernetes Manifests         | Helm Charts                      |
|------------------------|-----------------------------|----------------------------------|
| Format                 | YAML files                   | Packaged charts (YAML + templates) |
| Reusability            | Low                          | High (templating and values)     |
| Versioning             | Manual                       | Built-in chart versioning        |
| Dependency Management  | Manual                       | Supported via `requirements.yaml`|
| Release Management     | Manual                       | Automated with Helm              |

## Helm Architecture

- **Helm CLI**: The command-line tool for users to interact with Helm.
- **Helm Library**: Handles chart rendering, packaging, and more.
- **Kubernetes Cluster**: Where charts are deployed as releases.
- **Chart Repository**: Stores and distributes Helm charts.
- **Release**: A running instance of a chart in a Kubernetes cluster.

```
User
    |
Helm CLI
    |
Chart Repository <----> Helm Library <----> Kubernetes API Server
```

## References

- [Helm Documentation](https://helm.sh/docs/)

## How Helm Charts Help Manage Kubernetes

Helm charts simplify Kubernetes application management by:

- **Packaging**: Bundle all Kubernetes resources (Deployments, Services, ConfigMaps, etc.) into a single, reusable chart.
- **Templating**: Use variables and templates to customize deployments for different environments without duplicating YAML files.
- **Versioning**: Track and manage different versions of your applications, making rollbacks and upgrades easy.
- **Dependency Management**: Define and manage dependencies between charts, enabling modular and scalable application architectures.
- **Release Management**: Install, upgrade, rollback, and uninstall applications with simple Helm commands, streamlining the deployment process.

---

## Installing a Helm Chart with Pre-requisites

### Pre-requisites

1. **A Running Kubernetes Cluster**  
    You can use any of the following:
    - **EKS**: Amazon Elastic Kubernetes Service
    - **GKE**: Google Kubernetes Engine
    - **AKS**: Azure Kubernetes Service
    - **microk8s**: Lightweight Kubernetes for local development (used in this demo)

### Setting Up microk8s on Ubuntu

Follow the [microk8s documentation](https://microk8s.io/docs/getting-started):

```bash
sudo apt update -y
sudo snap install microk8s --classic --channel=1.31
```

Add your user to the `microk8s` group:

```bash
sudo usermod -a -G microk8s $USER
```

Set up your kube config directory:

```bash
mkdir -p ~/.kube
chmod 0700 ~/.kube
```

Activate the new group:

```bash
newgrp microk8s
# or
su - $USER
```

Check microk8s status:

```bash
microk8s status --wait-ready
```

### Install kubectl

```bash
sudo snap install kubectl --classic
```
Or follow the [official documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux).

To use kubectl with microk8s:

```bash
microk8s kubectl get services
alias kubectl='microk8s kubectl'
```
