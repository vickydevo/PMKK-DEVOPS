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