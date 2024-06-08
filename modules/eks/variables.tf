

########################################################################################################################
## EKS variables
########################################################################################################################

variable "eks_cluster_name" {
  description = "name of the EKS cluster name"
  type = string
  default = "qa-eks"
}

########################################################################################################################
## Service variables
########################################################################################################################

variable "namespace" {
  description = "Namespace for the resources"
  default     = "QA-cluster"
  type        = string
  
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "QA-cluster"
  type        = string
}

variable "vpc_id" {
  description = "default value for vpc"
  default = "non-prod-vpc"
  type = string
  
}

variable "subnet_id" {
  description = "default value for subnet"
  type = list(string)
  
}