
variable "env" {
  type        = string
  description = "The environment to deploy into"
}

variable "complex_data" {
  description = "bla bla bla"
  type = map(object({
    region     = string
    cidr_block = string
    private_subnets = list(object({
      az         = string
      cidr_block = string
    }))
    public_subnets = list(object({
      az         = string
      cidr_block = string
    }))
  }))
}

# This is a nice example of using a loop to use a module over multiple regions.
# It unfortunately does not work with providers though. 
# That is a bug that has been reported on the terraform github account and has
# been ignored by the makers of terraform
# module "a_region" {
#     source = "./modules/vpc"
#     for_each = var.complex_data
#     aws_region = each.key
#     cidr_block = each.value.cidr_block
#     private_subnets = each.value.private_subnets
#     public_subnets = each.value.public_subnets
#     env = var.env
#     providers = {
#       aws = aws.eu
#     }
# }

module "region_us_east_1" {
  source          = "./modules/vpc"
  aws_region      = var.complex_data["us-east-1"].region
  cidr_block      = var.complex_data["us-east-1"].cidr_block
  private_subnets = var.complex_data["us-east-1"].private_subnets
  public_subnets  = var.complex_data["us-east-1"].public_subnets
  env             = var.env
  providers = {
    aws = aws.us
  }
}

module "region_eu_west_1" {
  source          = "./modules/vpc"
  aws_region      = var.complex_data["eu-west-1"].region
  cidr_block      = var.complex_data["eu-west-1"].cidr_block
  private_subnets = var.complex_data["eu-west-1"].private_subnets
  public_subnets  = var.complex_data["eu-west-1"].public_subnets
  env             = var.env
  providers = {
    aws = aws.eu
  }
}
