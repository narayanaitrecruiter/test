# The module VPC will create a vpc and subnet as this is called in the main.tf. 
# The output of the vpc creation is vpc_id and subnet_ids.
# Then we are passing the vpc ids and subnet values from vpc to ECS, RDS, and other modules. 

# the values will be taken fromm the main.tf.. if you dont declare any values, then it will fetch from the default variables declared in the module. 
# Module is the standard folder which has commplete structure to deploy everything... 
# You can do or play anything using these modules in the main.tf.
# this is the folder which you have...
# i have split the ECS module into ECS and  ecs service. 
# for the cloudfront change the bucket name wherever necessary.

module "vpc" {
  source = "./modules/vpc"

}


module "ecs-cluster" {
  source     = "./modules/ecs"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  keypair = "mykeypair"  ##### update this file name without fail.
}

module "eks" {
  source    = "./modules/eks"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_ids
}

module "rds" {
  source     = "./modules/rds"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  # for aurora password -The password must be between 8 and 41 characters long, and contain at least one uppercase letter, one lowercase letter, and one number.
  aurorapassword = "Testingaurorapassword1"
  mysqlusername = "admin"
  postgresusername = "admin"
  #engine_version    = "6.2.6"
}

module "lambda" {
  source = "./modules/lambda"
}

module "ecr" {
  source = "./modules/ecr"
}



/* ------------------------------ AUTH SERVICE ------------------------------ */
module "auth-ecs-service" {
  source  = "./modules/ecsservice"
  subnet_ids = module.vpc.subnet_ids
  vpc_id = module.vpc.vpc_id
  cluster_id = module.ecs-cluster.ecs_cluster_id

  container_port = 80
  host_port = 81
  task_definition_family = "auth"
  container_image = "httpd:latest"
  }

/* ----------------------------- PAYMENT SERVICE ---------------------------- */

module "payment-ecs-service" {
  source  = "./modules/ecsservice"
  subnet_ids = module.vpc.subnet_ids
  vpc_id = module.vpc.vpc_id
  cluster_id = module.ecs-cluster.ecs_cluster_id

  container_port = 80
  host_port = 80
  task_definition_family = "payment"
  container_image = "nginx:latest"
  }
