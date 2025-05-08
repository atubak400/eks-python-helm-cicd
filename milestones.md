# 🛠️ Updated Mini-Milestones for EKS + GitHub Actions + Helm Project

## 1. Set Up GitHub Repository

* Push your Python application code to a new GitHub repository.
* Include a basic `Dockerfile` to containerize your app.

## 2. Container Registry Setup (Amazon ECR with OIDC Authentication)

* Create an Amazon ECR repository to store your Docker images.
* Ensure your GitHub repository is linked to your **GitHubActionsEKSRole** using OIDC.
* No need to store `AWS_REGION` or `ECR_REPOSITORY_URI` as GitHub Secrets.
* Hardcode required environment variables inside your GitHub Actions workflow:

```yaml
env:
  AWS_REGION: us-east-1
  AWS_ACCOUNT_ID: 136600023723
  ECR_REPOSITORY: my-eks-python-app
```

* GitHub Actions should:

  * Authenticate securely to AWS via OIDC.
  * Login to ECR.
  * Build, tag, and push Docker images automatically.

## 3. Build and Push Docker Image Using GitHub Actions

* Create a GitHub Actions workflow file at `.github/workflows/docker-build.yml`.
* Configure it to:

  * Authenticate to AWS.
  * Build the Docker image.
  * Tag and push the image to ECR on every code push.

## 4. Infrastructure (EKS, VPC, IAM)

* EKS cluster, VPC, node groups, and IAM roles are already provisioned using Terraform.
* Simply verify access:

```bash
kubectl get nodes
```

* No need to recreate infrastructure unless manually destroyed.

## 5. Create Your Application Helm Chart

* Use `helm create myapp` to generate a starter Helm chart.
* Edit `deployment.yaml`, `service.yaml`, and `values.yaml` to match your app.
* Ensure the chart pulls the Docker image from ECR correctly.

## 6. Deploy the App to EKS Using Helm via GitHub Actions

* Extend your GitHub Actions workflow to deploy the app via Helm.
* Helm will:

  * Pull the latest image.
  * Upgrade or install the app on your EKS cluster.

## 7. Set Up Logging (CloudWatch + Fluent Bit + prometeus)

* Install Fluent Bit into EKS using AWS’s official Helm chart.
* Configure Fluent Bit to send pod logs to Amazon CloudWatch Logs.
* Validate logs appear in the correct CloudWatch log group.

## 8. Implement Secrets Management (AWS Secrets Manager + IRSA)

* Create a Kubernetes ServiceAccount linked to an IAM Role (IRSA).
* Grant permissions to fetch secrets from AWS Secrets Manager.
* Update your Python app to retrieve secrets dynamically at runtime.

## 9. Implement Blue-Green Deployment (Argo Rollouts via Helm)

* Install Argo Rollouts using Helm.
* Update Helm charts to use `Rollout` instead of `Deployment` resources.
* Modify GitHub Actions workflow to apply Argo Rollouts during deploy.
* Enable traffic shifting strategies for safe deployments.

## 10. Test Full CI/CD Flow

* Push code changes and verify:

  * Docker image builds and pushes to ECR.
  * Helm chart upgrades and redeploys the app.
  * Blue-Green deployment via Argo Rollouts works.
  * Application fetches secrets securely at runtime.
  * Logs appear and are readable in CloudWatch.
