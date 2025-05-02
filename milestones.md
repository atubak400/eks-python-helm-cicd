# 🛠️ Mini-Milestones for Your EKS + GitLab CI/CD + Helm Project
## 1. Set Up GitLab Repository

* Push your simple Python application code to a new GitLab repository.
* Include a basic Dockerfile to containerize your app.

## 2. Container Registry Setup

* Choose a container registry (GitLab Container Registry or Docker Hub).
* Create a GitLab CI/CD secret if needed to authenticate.

## 3. Build and Push Docker Image Using GitLab CI/CD

* Write a `.gitlab-ci.yml` that builds the Docker image and pushes it to your registry on every code push.

## 4. Set Up Infrastructure (Terraform or eksctl)

* Create your EKS cluster, VPC, IAM roles, and node groups.
* Make sure `kubectl` can connect to your cluster (`kubectl get nodes` should work).

## 5. Create Your Application Helm Chart

* Use `helm create myapp` to generate a starter Helm chart.
* Modify the default templates (`deployment.yaml`, `service.yaml`) to suit your app.
* Package your app's container image (it will be updated later by GitLab CI).

## 6. Deploy the App to EKS Using Helm via GitLab CI/CD

* Add a Helm deployment stage to your `.gitlab-ci.yml` that installs/updates the Helm chart in your cluster.
* Ensure your GitLab runner has access to your Kubernetes cluster (e.g., using a Kubernetes service account token).

## 7. Implement Secrets Management (AWS Secrets Manager + IRSA)

* Create a Kubernetes service account linked with an IAM role that allows access to Secrets Manager.
* Update your Python app to fetch secrets at runtime.

## 8. Set Up Logging (CloudWatch + Fluent Bit via Helm)

* Install Fluent Bit on your EKS cluster using the AWS-provided Helm chart.
* Confirm that your app logs show up in CloudWatch Logs.

## 9. Implement Blue-Green Deployment (Argo Rollouts via Helm)

* Install Argo Rollouts on the cluster using Helm.
* Update your app's Helm chart to use a Rollout resource instead of a standard Deployment.
* Set your GitLab CI to trigger a rollout update on new deployments.

## 10. Test Full Flow

* Push new changes to GitLab and verify: Docker build → push → Helm upgrade → Blue-Green switch → Secrets loaded → Logs appear in CloudWatch.

