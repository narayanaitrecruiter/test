########################################################################################################################
## Create VPC with a CIDR block that has enough capacity for the amount of DNS names you need
########################################################################################################################

resource "aws_vpc" "non_prod_vpc" {

  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = var.environment
  }
}

########################################################################################################################
## Create Internet Gateway for egress/ingress connections to resources in the public subnets
########################################################################################################################

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.non_prod_vpc.id

  tags = {
    name = var.environment
  }
}
