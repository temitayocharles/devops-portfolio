#!/bin/bash

mkdir -p devops-portfolio/assets/logos
mkdir -p devops-portfolio/assets/diagrams
mkdir -p devops-portfolio/assets/profile

echo "Downloading AWS logo..."
curl -L https://raw.githubusercontent.com/gilbarbara/logos/main/logos/aws.svg -o devops-portfolio/assets/logos/aws.svg

echo "Downloading Kubernetes logo..."
curl -L https://raw.githubusercontent.com/gilbarbara/logos/main/logos/kubernetes.svg -o devops-portfolio/assets/logos/k8s.svg

echo "Downloading RDS architecture diagram..."
curl -L https://raw.githubusercontent.com/cloudacademy/amazon-rds-architecture/main/images/rds-architecture.png -o devops-portfolio/assets/diagrams/rds-arch.png

echo "Downloading placeholder profile photo..."
curl -L https://raw.githubusercontent.com/identicons/github/main/avatars/default.png -o devops-portfolio/assets/profile/profile.png

echo "✅ Assets downloaded and saved in appropriate folders."
