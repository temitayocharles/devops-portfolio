# CI/CD with GitHub Actions + EKS

## Overview
CI/CD pipeline built using GitHub Actions for microservice deployments into EKS clusters using Docker, Helm, and ArgoCD.

## Features
- gitleaks, Checkov, SonarQube, Trivy scanning
- Docker image build and push to Amazon ECR
- Helm deployment to ArgoCD for GitOps rollout
- Istio + ExternalDNS + Prometheus stack

## Diagram
![CI/CD Pipeline](../assets/diagrams/cicd-pipeline.png)
