include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
}

include "complex" {
  path = find_in_parent_folders("per_region_data.hcl")
  expose = true
}

terraform {
  source = "../../..//modules/vpc"
}

locals {
  aws_region = include.root.locals.aws_region
  complex = include.complex.locals.complex  
}

inputs = {
  aws_region = local.aws_region
  cidr_block = local.complex[local.aws_region].cidr_block
  private_subnets = local.complex[local.aws_region].private_subnets
  public_subnets = local.complex[local.aws_region].public_subnets
  env = include.env.locals.env
}
