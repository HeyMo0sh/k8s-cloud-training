  # One‑Hour Lab (Azure): AKS + Terraform + GitHub Actions

  Deploy an AKS cluster using Terraform driven by GitHub Actions.

  ## Prereqs
  - Azure subscription (Contributor on target scope)
  - GitHub repo with permission to set secrets
  - Optional: Azure CLI and kubectl locally

  ## Auth options (pick ONE)
  ### A) OIDC (recommended)
  1. Create an **App Registration**; grant **Contributor** at subscription or RG.
  2. In GitHub → Settings → Actions → OIDC: add a **Federated Credential** for this repo/branch.
  3. Set repo secrets:
     - `AZURE_CLIENT_ID`
     - `AZURE_TENANT_ID`
     - `AZURE_SUBSCRIPTION_ID`

  ### B) Legacy secret
  Create a service principal:
  ```bash
  az ad sp create-for-rbac \
--name aks-lab-sp \
--role Contributor \
--scopes /subscriptions/<SUBSCRIPTION_ID> \
--sdk-auth
  ```
  Put JSON into repo secret `AZURE_CREDENTIALS`.

  ## Run the workflow
  - Actions → **Terraform AKS CI** → Run
  - Terraform will `init`, `plan`, `apply` in `azure/terraform`

  ## Variables (defaults)
  - Region: `australiaeast`
  - VNet: `10.74.74.0/26`; Subnet: `10.74.74.0/27`
  - AKS: `aks-cluster-002`; Node pool: `npapps001`

  ## Validate
  ```bash
  az aks get-credentials -g rg-aksdemo -n aks-cluster-002 --admin --overwrite-existing
  kubectl get nodes -o wide
  ```

  ## Clean up
  ```bash
  terraform -chdir=azure/terraform destroy -auto-approve
  # or:
  az group delete -n rg-aksdemo -y
  ```
