The entire code will help you to deploy multiple services which will be deployed in main.tf however the services which you would like to deploy need to call from the modules folder. 
The modules folder contains the modules 
 ECR (elastic container registry - ecr folder) ,
 ecs (elastic container service -ecs folder) -all the required components, 
 ecsservices - ecs-services like task definitions and associated serices, load balancers in the ecs services folder
 eks - elastic kubernetes services (all the required components in eks folder)
 lambda - all the required components for lambda folder
 rds - aurora, postgres, mysql, redis cluster definitions and its associated variables.
 vpc - vpc creation, subnets, its associated components in this folder.

# Note : ECS cluster definition is in EC2 
How to deploy a service : 
in the main.tf, use the below block

The below block will create vpc module using the source /module/vpc

module "vpc" {
  source = "./modules/vpc"
}

variable preference : the variables inside the modules folder preceeded by variables/values which are declared in main.tf/variables.tf. 

now lets create a service payment module.  

# by declaring the below code, this module will call the ecsservice module and will create the payment-ecs-service on the ecs cluster.
# in below module, we are using the variables/output values created from vpc , and ecs cluster 

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

  # similary, we can create any number of services/task definitions using the above block. only thing,, we have to change the variables/values to create new services. we can override the values provided in the modules.


  # The use of modules is to reusability. To reuse the code, we will create the modules. So we are using the ecsservice code and we can crate any number of services. 
  
  # similarly, we an create addional services and use the existing services by simply passing the vallues from the existing environments. 

  