# One‑Hour Lab: GitHub Actions + Terraform → Azure (AKS + RG)

**Goal:** In ~60 minutes, attendees will fork this repo, wire up GitHub Actions with Azure credentials, and deploy a Resource Group and a 1‑node AKS cluster using Terraform.

---

## What we’ll build
- Azure **Resource Group** and **AKS** (1 node, small size for speed).
- CI/CD via **GitHub Actions** running Terraform (`init/plan/apply`).
- Secrets kept in **GitHub Secrets** (no credentials in code).

> ⚠️ Cluster creation can take ~10–15 minutes. We’ll do a quick “RG‑only” apply first to prove the pipeline, then deploy AKS.

---

## Prereqs (attendees)
- Azure subscription (Contributor access).
- GitHub account.
- **Azure CLI** locally (optional, but helpful): `brew install azure-cli` on macOS.

---

## Timeline (60 minutes)

### 0–10 min — Fork & explore
1. Fork this repo to your GitHub account.
2. Review files:
   - `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tf`
   - `.github/workflows/terraform-azure.yml` (CI pipeline)
   - `terraform.tfvars.example` (do **not** commit secrets; we’ll use GitHub Secrets)

### 10–20 min — Create a Service Principal (SP)
> Instructor shows this once; attendees run in their own subscription.

```bash
# Get your subscription ID (save it)
az account show --query id -o tsv

# Create a SP scoped to the subscription (role: Contributor)
SUBSCRIPTION_ID=<paste>
az ad sp create-for-rbac   --name "tf-gha-sp"   --role Contributor   --scopes /subscriptions/$SUBSCRIPTION_ID   --sdk-auth false
```

**Copy these values** from the output:
- `appId` → will become **ARM_CLIENT_ID**
- `password` → will become **ARM_CLIENT_SECRET**
- `tenant` → **ARM_TENANT_ID**
- Your `SUBSCRIPTION_ID` → **ARM_SUBSCRIPTION_ID**

### 20–30 min — Add GitHub secrets
In your fork → **Settings → Secrets and variables → Actions → New repository secret**. Add:

- `ARM_CLIENT_ID`  
- `ARM_CLIENT_SECRET`  
- `ARM_TENANT_ID`  
- `ARM_SUBSCRIPTION_ID`

> The workflow maps these to `TF_VAR_appId` and `TF_VAR_password` automatically so Terraform can create AKS with your SP.

### 30–40 min — First run (RG only) to validate the pipeline
Open **Actions** tab → run **“Terraform Plan/Apply”** via **Run workflow** (or push a change to `main`).  
To speed‑check, target just the Resource Group:

1. In the Actions **Run workflow** dialog, add an input called `RG_ONLY`? (easy route: temporarily edit the workflow to add `-target azurerm_resource_group.default`), or instructor demonstrates:

```bash
# Quick option: edit the Plan step locally and commit this line temporarily:
terraform plan -target=azurerm_resource_group.default -out tfplan -input=false
```

2. Wait for **Init/Plan/Apply** to succeed (usually ~2–3 minutes).

### 40–60 min — Deploy AKS (1 node)
Revert the temporary `-target` (or re-run the default workflow). This time it will create the AKS cluster:

- `default_node_pool.node_count = 1` and `vm_size = Standard_B2s` keep it small.
- Expect 10–15 minutes for the cluster creation.

**Outputs:**  
After success, in the job log you’ll see:
- `resource_group_name`
- `kubernetes_cluster_name`

---

## (Optional) Connect `kubectl` to your new AKS
```bash
# install kubectl if needed
brew install kubectl

# login and fetch kubeconfig
az login
az account set --subscription "$SUBSCRIPTION_ID"
az aks get-credentials -g <resource_group_name> -n <kubernetes_cluster_name>

kubectl get nodes
```

---

## Clean up
When done, destroy to avoid charges:
- From the Actions **Run workflow**, change the final step to:
  ```bash
  terraform destroy -auto-approve
  ```
- Or locally:
  ```bash
  terraform destroy
  ```

---

## Repo structure

```
.
├── .github/
│   └── workflows/
│       └── terraform-azure.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tf
├── terraform.tfvars.example
└── .gitignore
```

---

