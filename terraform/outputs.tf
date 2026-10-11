output "vpc_id" {
  description = "ID of the project VPC."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnets used by EKS."
  value       = module.vpc.private_subnets
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "EKS Kubernetes API endpoint."
  value       = module.eks.cluster_endpoint
}

output "aws_region" {
  description = "AWS region containing the cluster."
  value       = var.aws_region
}
