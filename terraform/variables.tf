variable "aws_region" {
  description = "AWS region for the AI Gateway."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "ai-gateway-demo"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "ai-gateway-demo"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS."
  type        = string
  default     = "1.37"
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "Public IPv4 CIDRs allowed to access the EKS API endpoint."
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for the initial CPU node group."
  type        = string
  default     = "t3.large"
}

variable "node_min_size" {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 2
}

variable "node_desired_size" {
  description = "Initial desired number of worker nodes."
  type        = number
  default     = 1
}
