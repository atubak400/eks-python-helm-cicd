# How I Solved EKS Access Issues (Corrected Version)

## Step 1: Create an IAM Role (Trusted Entity = AWS Account)

- Go to **IAM > Roles > Create Role**.
- Choose **Trusted Entity Type**: **AWS Account**.
- Trust: **This Account** (your own AWS Account ID will be prefilled).
- No need to select any service or use-case.
- Name the role **EKSAdminRole**.
- **Do not attach any permissions** during role creation.

## Step 2: Use Terraform to Link Role to Kubernetes Cluster Access

In my `main.tf`, inside the `module "eks"`, I added:

```hcl
access_entries = {
  admin = {
    principal_arn = "arn:aws:iam::136600023723:role/EKSAdminRole"
    type          = "STANDARD"

    policy_associations = {
      cluster-admin = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
  }
}
```

- This maps the `EKSAdminRole` directly as a `system:masters` user inside the cluster.

## Step 3: Apply Terraform

Run:

```bash
terraform apply
```

- Terraform will automatically attach the correct `AmazonEKSClusterAdminPolicy` and update the EKS authentication settings.

## Step 4: Update my kubeconfig

After cluster creation, I updated my kubeconfig to authenticate using the role:

```bash
aws eks update-kubeconfig \
  --region us-east-1 \
  --name my-eks-cluster \
  --role-arn arn:aws:iam::136600023723:role/EKSAdminRole
```

✅ This ensures `kubectl` uses the Role for access.

## Step 5: Confirm Access

```bash
kubectl get nodes
```

✅ Successful! I could see the cluster nodes in `Ready` state.

---

# Key Reminders for Future

- **Always use a dedicated IAM Role** (not just an IAM User) for EKS access.
- **Trusted entity must be AWS Account**, not AWS Service.
- **Terraform `access_entries`** should be used instead of manual aws-auth editing.
- **Update kubeconfig with `--role-arn`**.

✅ If these steps are followed, EKS access will work every time without errors.
