###################################################
#VPC
###################################################

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "eks_vpc_cidr" {
  description = "The CIDR block for the VPC that will be created."
  type        = string
  default     = "10.0.0.0/16"
}

variable "eks_vpc_name" {
  description = "The name of the VPC that will host the EKS cluster."
  type        = string
  default     = "eks_vpc"
}

variable "cloud9_vpc_cidr" {
  description = "The CIDR block for the VPC that will be created."
  type        = string
  default     = "172.31.0.0/16"
}

variable "cloud9_vpc_name" {
  description = "The name of the VPC that will host the Cloud9 instance."
  type        = string
  default     = "cloud9_vpc"
}

variable "cloud9_owner_arn" {
  description = "The arn of the IAM user who would be the owner of the Cloud9 instance."
  type        = string
  default     = ""
}

###################################################
#EKS
###################################################

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.23`)"
  type        = string
  default     = "1.23"
}

#-------------------------------
# EKS Cluster Security Groups
#-------------------------------
variable "cluster_security_group_additional_rules" {
  description = "List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source"
  type        = any
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the EKS cluster will be deployed to"
}

variable "private_subnet_ids" {
  description = "List of the private subnet IDs"
  type        = list(string)
  default     = []
}

