# Kubernetes Ingress: Overview and Comparison with LoadBalancer

## What is Ingress?

**Ingress** is a Kubernetes API object that manages external access to services within a cluster, typically HTTP and HTTPS traffic. It acts as an application layer (Layer 7) load balancer, enabling advanced routing and centralized management of incoming requests.

## What is an Ingress Controller?

An **Ingress Controller** is a component that implements the Ingress resource. It listens for changes to Ingress resources and configures the underlying load balancer or reverse proxy (such as NGINX, Traefik, or cloud-native controllers) to route external traffic according to the defined rules.

## What is an Ingress Resource?

An **Ingress Resource** is a Kubernetes object where you define routing rules for external traffic. These rules can include:

- **Path-based routing:** Direct traffic to different services based on URL paths (e.g., `/api` vs `/web`).
- **Host-based routing:** Route traffic based on hostnames (e.g., `app1.example.com` vs `app2.example.com`).
- **TLS termination:** Secure traffic using SSL/TLS certificates.

The Ingress Controller reads these rules and enforces them at the cluster edge.

## Quick Summary

- **Ingress** = Traffic routing rules + external access to services.
- **Ingress Resource (YAML):** The Kubernetes object where you define rules for routing external HTTP/S traffic (hosts, paths, backends/services).
- **Ingress Controller:** The actual component (like NGINX, Traefik, or others) running inside the cluster that listens to those Ingress resource rules and implements the traffic routing.

**![Image](https://github.com/user-attachments/assets/dfbec2ae-26eb-4e83-9fa7-fe83c0b3be32)**



## Ingress vs LoadBalancer Service

| Feature                | Ingress                                   | LoadBalancer Service                  |
|------------------------|-------------------------------------------|---------------------------------------|
| Layer                  | 7 (HTTP/HTTPS, application)               | 4 (TCP/UDP, transport)                |
| Routing                | Path/host-based, advanced rules           | Direct to service, no routing logic   |
| TLS Termination        | Supported                                 | Supported (per service)               |
| Cost                   | One controller for many services          | One load balancer per service         |
| Use Case               | Centralized, flexible traffic management  | Simple, direct external access        |

**Summary:**  
- Use **Ingress** for advanced, centralized routing and cost-effective management of multiple services.
- Use **LoadBalancer Service** for simple, direct access to a single service.
