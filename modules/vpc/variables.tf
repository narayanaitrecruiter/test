
########################################################################################################################
## Network variables
########################################################################################################################



variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.0.0.0/16"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "az_count" {
  default = 1
}

variable "availability_zones" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]

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
