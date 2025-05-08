# 🛠️ Updated Mini-Milestones for EKS + GitHub Actions + Helm Project

## 1. Set Up GitHub Repository

* Push your Python application code to a new GitHub repository.
* Include a basic `Dockerfile` to containerize your app.

## 2. Container Registry Setup (Amazon ECR with OIDC Authentication)

* Create an Amazon ECR repository to store your Docker images.
* Ensure your GitHub repository is linked to your **GitHubActionsEKSRole** via OIDC.
* In your GitHub Secrets, store:

  * `AWS_REGION` — your region (e.g., `eu-west-2`)
  * `ECR_REPOSITORY_URI` — your ECR repo URI (e.g., `136600023723.dkr.ecr.eu-west-2.amazonaws.com/myapp`)
* Update your GitHub Actions workflow to:

  * Use `aws-actions/configure-aws-credentials` with OIDC.
  * Log in to ECR and push Docker images securely without permanent AWS keys.

## 3. Build and Push Docker Image Using GitHub Actions

* Create a GitHub Actions workflow file at `.github/workflows/docker-build.yml`.
* Configure it to:

  * Authenticate to AWS using OIDC.
  * Build the Docker image.
  * Tag and push the image to your ECR repository on every code push.

## 4. Infrastructure Already Set Up (EKS, VPC, IAM)

* EKS cluster, VPC, node groups, and IAM roles were already set up with Terraform.
* Simply verify access works by running:

```bash
kubectl get nodes
```

* No need to recreate infrastructure unless you destroy and rebuild later.

## 5. Create Your Application Helm Chart

* Use `helm create myapp` to generate a starter Helm chart.
* Edit `deployment.yaml`, `service.yaml`, and `values.yaml` to match your app.
* Ensure the Helm chart pulls your Docker image from ECR.

## 6. Deploy the App to EKS Using Helm via GitHub Actions

* Extend your GitHub Actions workflow to include a Helm deployment step after pushing the Docker image.
* Store any kubeconfig or authentication details safely if needed, but prefer assuming roles with OIDC.
* Deploy your app using Helm from the GitHub Actions runner to your EKS cluster.

## 7. Set Up Logging (CloudWatch + Fluent Bit via Helm)

* Install Fluent Bit into your EKS cluster using AWS’s official Helm chart.
* Configure Fluent Bit to send logs from your application pods to Amazon CloudWatch Logs.
* Confirm logs are appearing in the correct CloudWatch log group.

## 8. Implement Secrets Management (AWS Secrets Manager + IRSA)

* Create a Kubernetes ServiceAccount linked to an IAM Role (IRSA setup).
* Grant the IAM Role permissions to access secrets from AWS Secrets Manager.
* Update your Python application to fetch secrets at runtime using the AWS SDK.
* Validate secret retrieval through application logs.

## 9. Implement Blue-Green Deployment (Argo Rollouts via Helm)

* Install Argo Rollouts into your EKS cluster using Helm.
* Update your Helm chart to use `Rollout` resources instead of standard `Deployment`.
* Modify your GitHub Actions workflow to apply Rollouts during deployment updates.
* Enable traffic shifting strategies to smoothly switch between versions.

## 10. Test Full Flow

* Push code changes to GitHub and confirm the complete automation works:

  * Docker image builds and pushes to ECR.
  * Helm chart upgrades and application is redeployed.
  * Blue-Green deployment succeeds via Argo Rollouts.
  * Application secrets are fetched securely at runtime.
  * Logs are available and readable in CloudWatch.

