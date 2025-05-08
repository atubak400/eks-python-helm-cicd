# 🛠️ Mini-Milestones for EKS + GitHub Actions + Helm Project

## 1. Set Up GitHub Repository

* Push your simple Python application code to a new GitHub repository.
* Include a basic `Dockerfile` to containerize your app.

## 2. Container Registry Setup

* Choose a container registry (Docker Hub or Amazon ECR).
* Create GitHub repository secrets (`DOCKER_USERNAME`, `DOCKER_PASSWORD`, etc.) for authentication.

## 3. Build and Push Docker Image Using GitHub Actions

* Create a GitHub Actions workflow file at `.github/workflows/docker-build.yml`.
* Configure it to build your Docker image and push it to your registry on every code push.

## 4. Set Up Infrastructure (Terraform or eksctl)

* Create your EKS cluster, VPC, IAM roles, and node groups.
* Verify `kubectl get nodes` works from your machine.

## 5. Create Your Application Helm Chart

* Use `helm create myapp` to generate a starter Helm chart.
* Edit `deployment.yaml`, `service.yaml`, and other templates for your app.
* Ensure the chart pulls the correct Docker image.

## 6. Deploy the App to EKS Using Helm via GitHub Actions

* Extend your GitHub Actions workflow to deploy using Helm.
* Store kubeconfig or access credentials securely in GitHub secrets.
* Allow your GitHub runner to authenticate and deploy to EKS.

## 7. Set Up Logging (CloudWatch + Fluent Bit via Helm)

* Install Fluent Bit in the EKS cluster using the AWS-provided Helm chart.
* Confirm application logs are appearing in AWS CloudWatch Logs.

## 8. Implement Secrets Management (AWS Secrets Manager + IRSA)

* Create a Kubernetes service account linked to an IAM role.
* Grant the IAM role permissions to read from AWS Secrets Manager.
* Update your Python app to fetch secrets at runtime using the AWS SDK.
* Confirm application logs are appearing in AWS CloudWatch Logs.

## 9. Implement Blue-Green Deployment (Argo Rollouts via Helm)

* Install Argo Rollouts in your EKS cluster via Helm.
* Update your Helm chart to use a `Rollout` instead of a standard `Deployment`.
* Modify your GitHub Actions workflow to trigger a rollout update after a new deployment.

## 10. Test Full Flow

* Push code changes to GitHub and confirm the following flow:

  * Docker image build and push
  * Helm chart upgrade
  * Blue-Green switch via Argo Rollouts
  * Secrets fetched dynamically
  * Logs visible in CloudWatch
