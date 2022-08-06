variable "environment" {
  description = "The Deployment environment"
  default = "dev"
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
  default =  "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list
  description = "The CIDR block for the public subnet"
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnets_cidr" {
  type        = list
  description = "The CIDR block for the private subnet"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "region" {
  description = "The region to launch the bastion host"
  default = "us-west-2"
}

variable "availability_zones" {
  type        = list
  description = "The az that the resources will be launched"
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}


# variable "public_subnet_list" {
  
# }

# variable "vpc_id" {
  
# }

# variable security_group_id {

# }

# variable "aws_lb_target_group_arn" {
  
# }

