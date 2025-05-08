# EKS Python App Deployment Project - Full Milestone Walkthrough

This README describes how we successfully built and deployed a Python application to AWS EKS, using Terraform, Docker, Helm, ECR, GitHub Actions (OIDC authentication), Fluent Bit, and CloudWatch.

## 1. Set Up GitHub Repository

* Created a GitHub repo `eks-python-helm-cicd`.
* Pushed the Flask Python app, Dockerfile, Terraform files, and Helm chart into the repo.
* Created `.github/workflows/main.yml` GitHub Actions workflow file.

## 2. Container Registry Setup (Amazon ECR)

* Manually created an ECR repo: `my-eks-python-app`.
* We did **not** store `AWS_REGION` or `ECR_REPOSITORY_URI` as GitHub secrets.
* Instead, we used direct environment variables in the GitHub Actions file.
* OIDC Role `GitHubActionsEKSRole` was set up properly.

## 3. Build and Push Docker Image Using GitHub Actions

* GitHub Actions workflow builds the Docker image for every push.
* Logs in securely to ECR using OIDC.
* Pushes the image to the `my-eks-python-app` ECR repository.

## 4. Infrastructure Already Set Up (EKS, VPC, IAM)

* We used Terraform to deploy VPC, EKS cluster, node groups, and IAM roles.
* Terraform modules were used (Terraform AWS modules).
* Confirmed EKS cluster is working by running:

```bash
kubectl get nodes
```

## 5. Create Your Application Helm Chart

* Created a minimal Helm chart manually:

  * `helm/Chart.yaml`
  * `helm/values.yaml`
  * `helm/templates/deployment.yaml`
  * `helm/templates/service.yaml`
* Configured the Helm chart to pull the Docker image from ECR.
* Service type was set to `LoadBalancer` for external access.

## 6. Deploy the App to EKS Using Helm via GitHub Actions

* Extended the GitHub Actions workflow.
* After pushing the Docker image, the workflow deploys/updates the app on EKS using Helm.
* Every GitHub push now automatically redeploys a new version.

## 7. Set Up Logging (CloudWatch + Fluent Bit via Helm)

* Created an IAM Policy `EKSFluentBitPolicy` allowing logs push to CloudWatch.
* Created a Role `EKSFluentBitRole` with OIDC trust for Kubernetes ServiceAccount.
* Created a `helm/fluentbit-values.yaml` to configure Fluent Bit.
* Updated GitHub Actions to deploy Fluent Bit automatically using Helm.
* Fluent Bit runs as DaemonSet and sends pod logs to CloudWatch.
* After fixing an OIDC trust mistake, Fluent Bit started successfully sending logs.

## 8. (Planned for next) - Implement Secrets Management

* Will integrate AWS Secrets Manager with Kubernetes (IRSA).

## 9. (Planned for next) - Implement Blue-Green Deployment with Argo Rollouts

* Will install Argo Rollouts to achieve progressive delivery.

## 10. Test Full Flow

* Every GitHub push triggers:

  * Docker build
  * Docker push
  * Helm upgrade
  * Fluent Bit already deployed
* Flask app is accessible externally via ELB.
* Logs are visible in CloudWatch.

---

# Conclusion

This project builds a **full production-ready pipeline** using AWS best practices:

* Secure (OIDC, no hardcoded AWS keys)
* Automated (CI/CD with GitHub Actions)
* Observable (logs via CloudWatch)
* Scalable (EKS-managed nodes)

---

# Next Steps

* Set up Secrets Manager (IRSA).
* Set up Argo Rollouts.
* Add monitoring with Prometheus/Grafana.

---

# Author

Kingsley Atuba

