# QuakeWatch - DevOps Final Project

QuakeWatch is a Python/Flask application that displays earthquake data.

> **Note:** The application itself was not developed by me. The original application was used as the base for this project.  
> My work focused on building the **DevOps infrastructure and deployment process around the application**.

---

## Project Overview

The goal of this project was to take an existing application and build a complete DevOps workflow around it — from containerization to automated deployment on AWS.

### Technologies

- Docker & Docker Compose
- Kubernetes
- Helm
- GitHub Actions
- Docker Hub
- Argo CD
- Terraform
- AWS EC2
- K3s
- Traefik

---

## Architecture

```text
Developer
    |
    v
GitHub
    |
    +---- GitHub Actions ----> Docker Hub
    |
    v
Argo CD / GitOps
    |
    v
AWS EC2
    |
    v
K3s
    |
    v
Helm Deployment
    |
    v
Traefik :80
    |
    v
QuakeWatch
```

---

## What I Implemented

### Docker

Containerized the Flask application and created a Docker Compose configuration for local deployment.

### Kubernetes

Created Kubernetes resources for the application, including:

- Deployment with multiple replicas
- Service
- ConfigMap & Secret
- Liveness and readiness probes
- Resource requests and limits
- Horizontal Pod Autoscaler
- CronJob

### Helm

Converted the Kubernetes configuration into a reusable Helm chart with configurable values.

### CI/CD

Created GitHub Actions workflows to:

- Install dependencies
- Run Pylint
- Build the Docker image
- Push the production image to Docker Hub after approved changes are merged

### GitOps

Used **Argo CD** to manage Kubernetes deployments from the Git repository using the GitOps approach.

### AWS & Terraform

Created the AWS infrastructure using Terraform, including:

- VPC and networking
- Security Group
- EC2 instance
- SSH access configuration

### K3s & Traefik

Installed K3s on the AWS EC2 instance and deployed QuakeWatch using the Helm chart.

K3s's built-in Traefik ingress controller exposes the application through the EC2 public IP on HTTP port `80`.

```text
Internet
   |
   v
EC2 Public IP :80
   |
   v
Traefik
   |
   v
Kubernetes Service
   |
   v
QuakeWatch Pods :5000
```

---

## Repository Structure

```text
.github/workflows/   # CI/CD pipelines
argocd/              # Argo CD / GitOps configuration
kubernetes/          # Kubernetes manifests
quakewatch-helm/     # Helm chart
terraform/           # AWS infrastructure
Dockerfile            # Container image
docker-compose.yaml   # Local container deployment
```

---

## DevOps Flow

```text
Code
  |
  v
GitHub
  |
  v
CI/CD
  |
  v
Docker Image
  |
  v
GitOps
  |
  v
Kubernetes / K3s
  |
  v
AWS EC2
```

This project demonstrates the process of taking an existing application and building a complete **containerized, automated, reproducible, and cloud-hosted DevOps environment** around it.

---

**Yoad Eliahu**  
DevOps Final Project