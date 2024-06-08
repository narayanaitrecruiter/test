
module "vpc" {
  source     = "./modules/vpc"
}

module "ecs" {
  source    = "./modules/ecs"
  vpc_id    = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
}

module "eks" {
  source    = "./modules/eks"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_ids

}

module "rds" {
  source    = "./modules/rds"
  vpc_id    = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
}
