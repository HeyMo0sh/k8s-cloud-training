# Kubernetes in the Cloud

## Log into Azure

git pull
az aks get-credentials --resource-group rg-trimble-001 --name aks-cluster-001
cd Manual_Deploy
kubectl delete -f deployment.yml
kubectl apply -f deployment.yml
kubectl get pods
kubectl get svc
-- hit the IP addres sin a browser
-- curl the IP address
-- hit the website again

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

Edit the main.tf file:

cluster_name = "aksdemoXXX"

Change XXX to your initials

## AWS

Change the following to be your number in the room:  ie Hamish is 11:

  cidr = "10.11.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
  public_subnets  = ["10.11.101.0/24", "10.11.102.0/24", "10.11.103.0/24"]


``` bash

aws --version
aws configure
cd k8s-cloud-training/Manual_Deploy/aws

terraform -v
terraform init
terraform validate
terraform plan
terraform apply
terraform apply -auto-approve
terraform destroy

aws eks list-clusters

# configure kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

## Azure

- Run in cloud shell
cd k8s-cloud-training/Manual_Deploy/azure
az -v
az upgrade

### Terraform

``` bash
terraform -v
terraform init
terraform validate
terraform plan
terraform apply
terraform apply -auto-approve
terraform destroy
```

```

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
```

## kubectl

```
kubectl version --client
kubectl get pods --all-namespaces
kubectl get nodes
kubectl get deployments
kubectl get services
```

Now go into main.tf and uncomment and 

terraform validate
terraform plan
terraform apply
terraform apply -auto-approve

## Helm

```
helm version
helm repo add opsmx https://helmcharts.opsmx.com/
helm install my-hello-kubernetes opsmx/hello-kubernetes --version 1.0.3
helm list
helm uninstall my-hello-kubernetes
```

terraform destroy