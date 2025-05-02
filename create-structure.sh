#!/bin/bash

# Set your project name
PROJECT_NAME="my-python-app"

# Create main project folder
mkdir -p $PROJECT_NAME

# Create top-level files
touch $PROJECT_NAME/.gitlab-ci.yml
touch $PROJECT_NAME/Dockerfile
touch $PROJECT_NAME/README.md

# Create app folder and files
mkdir -p $PROJECT_NAME/app
touch $PROJECT_NAME/app/main.py
touch $PROJECT_NAME/app/requirements.txt

# Create Helm chart structure
mkdir -p $PROJECT_NAME/helm/my-python-app/templates
touch $PROJECT_NAME/helm/my-python-app/Chart.yaml
touch $PROJECT_NAME/helm/my-python-app/values.yaml
touch $PROJECT_NAME/helm/my-python-app/templates/deployment.yaml
touch $PROJECT_NAME/helm/my-python-app/templates/service.yaml
touch $PROJECT_NAME/helm/my-python-app/templates/ingress.yaml
touch $PROJECT_NAME/helm/my-python-app/templates/rollout.yaml

# Create optional Terraform folder
mkdir -p $PROJECT_NAME/terraform
touch $PROJECT_NAME/terraform/main.tf
touch $PROJECT_NAME/terraform/variables.tf
touch $PROJECT_NAME/terraform/outputs.tf
touch $PROJECT_NAME/terraform/eks-cluster.tf

# Create optional scripts folder
mkdir -p $PROJECT_NAME/scripts
touch $PROJECT_NAME/scripts/deploy.sh
touch $PROJECT_NAME/scripts/setup-eks.sh

echo "✅ Project structure created successfully!"
