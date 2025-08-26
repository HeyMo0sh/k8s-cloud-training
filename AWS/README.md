# One‑Hour Lab (AWS): EKS + Terraform + GitHub Actions

Deploy an Amazon EKS cluster using Terraform driven by GitHub Actions.

## Prereqs
- AWS account capable of creating VPC/EKS/IAM
- GitHub repo with permission to set secrets
- Optional: AWS CLI and kubectl locally

## Auth options (pick ONE)
### A) OIDC (recommended)
- Create an **IAM Role** trusted by GitHub OIDC (audience: `sts.amazonaws.com`).
- Attach permissive policy for workshop (e.g., `AdministratorAccess`), tighten later.
- Set repo secret `AWS_ROLE_TO_ASSUME` = role ARN.

### B) Access keys
- Create an IAM user with programmatic access and set secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

## Run the workflow
- Actions → **Terraform EKS CI** → Run

## Variables (defaults)
- Region: `ap-southeast-2`
- VPC CIDR: `10.74.64.0/20`
- Public subnets: `10.74.64.0/24`, `10.74.65.0/24`
- Private subnets: `10.74.80.0/24`, `10.74.81.0/24`
- Cluster: `eks-cluster-002`; Node group: `ng-apps001`

## Validate
```bash
aws eks update-kubeconfig --name eks-cluster-002 --region ap-southeast-2
kubectl get nodes -o wide
```

## Clean up
```bash
terraform -chdir=aws/terraform destroy -auto-approve
```
