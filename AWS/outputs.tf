output "cluster_name" { value = aws_eks_cluster.this.name }
output "region"       { value = var.region }
output "cluster_endpoint" { value = data.aws_eks_cluster.this.endpoint }
output "cluster_ca" { value = data.aws_eks_cluster.this.certificate_authority[0].data, sensitive = true }
