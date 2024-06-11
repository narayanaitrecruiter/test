variable "vpc_id" {
  description = "default value for vpc"
  default = "non-prod-vpc"
  type = string
  
}

variable "subnet_ids" {
  description = "default value for subnet"
  type = list(string)
}


variable "aurorausername" {
  description = "Username for the Aurora database"
  type        = string
  default = "ireland"
}

variable "aurorapassword" {
  description = "Password for the Aurora database"
  type        = string
  default = "Aurorapassword123456"
}


variable "postgresusername" {
  description = "Password for the Aurora database"
  type        = string
  default = "admin"
}

variable "postgrespassword" {
  description = "Username for the Aurora database"
  type        = string
  default = "Postgrespasswordpostgrespassword123456"
}

variable "mysqlusername" {
  description = "Password for the Aurora database"
  type        = string
  default = "admin"
}

variable "mysqlpassword" {
  description = "Username for the Aurora database"
  type        = string
  default = "Mysqlpassword123456"
}

variable "availability_zones" {
  description = "Availability zones to use"
  type        = list
  default     = ["us-west-2a"]  
  
}

variable "engine_version_redis" {
  description = "Redis engine version"
  type        = string
  default     = "6.x"
  
}