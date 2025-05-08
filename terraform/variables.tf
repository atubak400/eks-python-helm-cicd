variable "aws_region" {
  description = "AWS region to deploy EKS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-python-cluster"
}
