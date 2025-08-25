# Kubernetes in the Cloud

# Code

The `start` and `end` folders contain the Terraform files 

`start` has the code as it exists at the beginning of the demos and `end` has the code as it exists at the end of the demos.

# Resources

## AWS

CLI - [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)

EKS - [https://aws.amazon.com/eks/](https://aws.amazon.com/eks/)

## Azure

CLI - [https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest](https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest)

AKS - [https://azure.microsoft.com/en-us/products/kubernetes-service](https://azure.microsoft.com/en-us/products/kubernetes-service)


## Terraform

General - [https://www.terraform.io/](https://www.terraform.io/)

1.5.5. release - [https://releases.hashicorp.com/terraform/1.5.5/](https://releases.hashicorp.com/terraform/1.5.5/)

Terraform Registry - [https://registry.terraform.io/](https://registry.terraform.io/)

## Other Tools

kubectl - [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

Helm - [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)

Hello Kubernetes repo - [https://github.com/paulbouwer/hello-kubernetes](https://github.com/paulbouwer/hello-kubernetes)

OpenTofu - [https://opentofu.org/](https://opentofu.org/)

# LAB Commands


## AWS

```
aws --version
aws configure
aws eks list-clusters

# configure kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

## Azure

```
az -v
az upgrade
az login --allow-no-subscriptions
az ad sp create-for-rbac -n aksdemo --skip-assignment
az aks list
az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)
```

## Terraform

```
terraform -v
terraform init
terraform validate
terraform plan
terraform apply
terraform apply -auto-approve
terraform destroy
```

## kubectl

```
kubectl version --client
kubectl get pods --all-namespaces
kubectl get nodes
kubectl get deployments
kubectl get services
```

## Helm

```
helm version
helm repo add opsmx https://helmcharts.opsmx.com/
helm install my-hello-kubernetes opsmx/hello-kubernetes --version 1.0.3
helm list
helm uninstall my-hello-kubernetes
```