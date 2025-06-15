#!/bin/bash

# Create directory structure
mkdir -p devops-portfolio/projects
mkdir -p devops-portfolio/assets/diagrams
mkdir -p devops-portfolio/assets/screenshots
mkdir -p devops-portfolio/styles
mkdir -p devops-portfolio/.github/workflows

# Create README.md
cat > devops-portfolio/README.md <<EOF
# Charles — DevOps Engineer Portfolio

Welcome to my portfolio. I'm a DevOps engineer focused on scalable infrastructure, CI/CD automation, Kubernetes operations, and cloud-native security.

## 🔧 Core Skills
- Terraform modules (parametrized, secure, YAML-driven)
- CI/CD pipelines (GitHub Actions, Docker, Helm, ArgoCD)
- Kubernetes (EKS, Istio, Kyverno, autoscaling)
- Cloud-native tooling (AWS, OCI, ExternalDNS, SOPS, ESO)

## 📁 Projects
- [RDS Terraform Module](./projects/rds-module.md)
- [CI/CD with GitHub Actions + EKS](./projects/eks-ci-cd.md)
- [AWS Budget Alerts via SNS](./projects/aws-budget-sns.md)
- [Automated EC2 Backup & AMI Cleanup](./projects/backup-ami-cleanup.md)
- [KMS Key Rotation Lambda](./projects/kms-rotation-lambda.md)

> This portfolio reflects practical, production-style work aligned with enterprise security and performance standards.

---
📨 Reach me via LinkedIn | Email available upon request
EOF

# Create index.html
cat > devops-portfolio/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Charles — DevOps Portfolio</title>
  <link rel="stylesheet" href="styles/style.css">
</head>
<body>
  <main>
    <h1>Charles — DevOps Engineer</h1>
    <p>Focused on CI/CD automation, Kubernetes, and cloud-native infrastructure.</p>

    <section>
      <h2>About Me</h2>
      <p>I am a DevOps Engineer with a passion for building secure, scalable, and automated infrastructure. I specialize in Kubernetes (EKS), CI/CD pipelines, cloud-native tooling, and infrastructure-as-code using Terraform. Over the course of my DevOps journey, I've independently built and deployed robust systems that follow enterprise best practices. This portfolio showcases real-world experience, problem-solving ability, and a deep commitment to production-grade standards.</p>
    </section>

    <h2>Projects</h2>
    <ul>
      <li><a href="projects/rds-module.md">RDS Terraform Module</a></li>
      <li><a href="projects/eks-ci-cd.md">CI/CD with GitHub Actions + EKS</a></li>
      <li><a href="projects/aws-budget-sns.md">AWS Budget Alerts via SNS</a></li>
      <li><a href="projects/backup-ami-cleanup.md">Automated EC2 Backup & AMI Cleanup</a></li>
      <li><a href="projects/kms-rotation-lambda.md">KMS Key Rotation Lambda</a></li>
    </ul>
  </main>
</body>
</html>
EOF

# Create style.css
cat > devops-portfolio/styles/style.css <<EOF
body {
  font-family: Arial, sans-serif;
  padding: 40px;
  background: #f9f9f9;
  color: #333;
}
main {
  max-width: 800px;
  margin: auto;
}
h1 {
  color: #005f73;
}
a {
  color: #0a9396;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
}
section {
  margin-bottom: 30px;
}
EOF

# Create GitHub Actions deploy workflow
cat > devops-portfolio/.github/workflows/deploy.yml <<EOF
name: Deploy Portfolio

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: \${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./devops-portfolio
EOF

# Create project pages
cat > devops-portfolio/projects/rds-module.md <<EOF
# AWS RDS Terraform Module

## Overview
Provisioned fully parameterized, secure RDS instances using Terraform modules integrated with Webforx standards.

## Features
- Supports PostgreSQL, MySQL, MSSQL
- Integrated KMS encryption, CloudWatch alarms, automated backups
- SNS-based failure alerts
- Fetched secrets from AWS Parameter Store

## Stack
Terraform, AWS RDS, KMS, SNS, CloudWatch, YAML config parsing

## Diagram
![RDS Architecture](../assets/diagrams/rds-architecture.png)
EOF

cat > devops-portfolio/projects/eks-ci-cd.md <<EOF
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
EOF

cat > devops-portfolio/projects/aws-budget-sns.md <<EOF
# AWS Budget Alerts via SNS

## Overview
Created a Terraform module to provision AWS Budgets and notify subscribers through SNS and email alerts.

## Features
- Threshold-based monthly budget alerts
- Uses centralized YAML input (`webforx.yaml`)
- SNS topic with email subscription list
EOF

cat > devops-portfolio/projects/backup-ami-cleanup.md <<EOF
# Automated EC2 Backup & AMI Cleanup

## Overview
Automated EC2 snapshot and AMI lifecycle cleanup using Lambda and Terraform.

## Features
- Snapshot creation and AMI retention policy
- SNS alerts on success/failure
- CloudWatch alarms for Lambda
- Logs to SSM Parameter Store
EOF

cat > devops-portfolio/projects/kms-rotation-lambda.md <<EOF
# KMS Key Rotation Lambda

## Overview
Built a Lambda function to automate 90-day key rotation for KMS keys without immediate deletion of old keys.

## Features
- SSM logging of new key metadata (KeyId, timestamp)
- CloudWatch monitoring with failure alerts
- Tagging for traceability
- Slack/Mattermost alerting integrated
EOF

echo "✅ Full portfolio with enhancements created at ./devops-portfolio"

