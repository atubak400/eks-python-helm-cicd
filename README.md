# my-eks-python-app

This project builds a simple Python Flask application, containerizes it using Docker, and deploys it to an AWS EKS Kubernetes cluster via GitLab CI/CD.

---

## 1. Project Setup (Local)

* Created project folders: `app/`, `helm/`, `scripts/`, `terraform/`.
* Created the base files:

  * `app/main.py` → simple Flask app.
  * `app/requirements.txt` → with Flask dependency.
  * `Dockerfile` → to containerize the app.
  * `helm/my-python-app/Chart.yaml`, `deployment.yaml`, `service.yaml`, `rollout.yaml`, `values.yaml` → basic Helm chart.
  * `.gitlab-ci.yml` → defines build and deploy stages for GitLab pipeline.
* Initialized Git:

  ```bash
  git init --initial-branch=main
  git remote add origin git@gitlab.com:USERNAME/REPO.git
  git add .
  git commit -m "Initial commit."
  git push --set-upstream origin main
  ```

---

## 2. GitLab Configuration for CI/CD (Website)

**To allow the GitLab CI/CD pipeline to build Docker images and push them to the GitLab Container Registry, and later deploy to EKS, the following steps were necessary:**

### a) Set Up Personal Access Token

* Go to: **GitLab > User Settings > Access Tokens**
* Created a **Personal Access Token** with these scopes:

  * `read_registry`
  * `write_registry`
  * (Optional for later: `api` if needed)
* Saved the token securely.

### b) Add CI/CD Variables

* Go to **Project > Settings > CI/CD > Variables**.
* Created two **protected** variables:

  * `CI_REGISTRY_USER` → your GitLab username.
  * `CI_REGISTRY_PASSWORD` → the personal access token created.
* These variables are used to login to the GitLab Container Registry during the pipeline.

### c) Enable Container Registry for the Project

* Go to **Project > Settings > General**.
* Under **Visibility, Project Features, Permissions**:

  * Made sure **Container Registry** is **enabled** (switched ON).
  * Set visibility to **Only Project Members** (important for pushing images).
* Confirmed that **CI/CD**, **Repository**, and other features are ON.

### d) Prepare `.gitlab-ci.yml`

* Added `build` stage:

  * Logs into GitLab Registry.
  * Builds Docker image.
  * Pushes Docker image to GitLab Registry.
* Added dummy `deploy` stage (to be replaced later with Helm commands).

---

## 3. First CI/CD Run

* Pushed changes to GitLab.
* GitLab triggered the pipeline automatically.
* Verified:

  * `build` job succeeded (Docker image built and pushed).
  * `deploy` job (dummy step) succeeded.
* Fixed early issues like:

  * SSH permission error (due to wrong URL or no SSH key).
  * Missing `requirements.txt` or empty Dockerfile errors.
  * "denied: requested access to the resource" error (fixed by setting token and enabling Container Registry).

---

## 4. Current Status

* Full CI/CD build stage working.
* Docker image stored inside **GitLab Container Registry**.
* Ready to proceed to:

  * **Deploy using Helm** to EKS cluster inside the pipeline.

---

# What's Next?

* Edit `values.yaml` to use dynamic GitLab image and tag.
* Update deploy stage to run `helm upgrade --install`.
* Connect GitLab runner to the EKS cluster using credentials.
* Fully automate app deployment after every push.

---

# Extra Notes

* Some minor Dockerfile security warnings were shown (about vulnerabilities), but they do not block building or pushing images. Can be handled later.
* Pipelines are visible under GitLab: **Build > Pipelines**.
* Every pipeline automatically links to its Git commit.

---

# End of README
