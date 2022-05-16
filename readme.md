# How to Deploy to multiple regions
Demonstrates how to deploy to multiple regions using either Terraform or Terragrunt.

# How it works for Terragrunt
This uses one set of terragrunt configuration files for ALL regions. Other online guides I have seen online suggest duplicating an entire set of terragrunt configuration files for each region. Terragrunt was founded on the principle of 'Don't Repeat Yourself' (DRY). Unfortunately that principle fell flat on it's face when it comes to multi-region deployments. But this approach gets around the endless duplication and uses one set of configs for all regions. 

The key to getting multi-region deployment to work is setting a provider up properly in terraform. A provider set up like this in terraform
```
provider "aws" {
  region = "us-east-1"
}
```
Will deploy to the us-east-1 region.
Deploying to the eu-west-1 region is as simple as declaring:
```
provider "aws" {
  region = "ue-west-1"
}
```
This obviously needs to be controlled from as high a level as possible, and we don't want to hard-code the region in a terraform file either. We want to compute it at runtime. 
For Terragrunt, our provider file is specified once anyways, so it's created in the generate block. See live/root.hcl.
```
provider "aws" {
  region = "${local.aws_region}"
}
```
Unfortunately, terragrunt does not have a way to pass in a variable from the command line to it's config files like terraform does. So we have to rely getting the region from an environment variable:
```
locals {
  aws_region = get_env("AWS_REGION")
}
...
provider "aws" {
  region = "${local.aws_region}"
}
```

# How it works for Terraform
Terraform simply uses a module to instantiate multiple resources. See main.tf. When invoking a module you can simply pass in a pre-declared provider and terraform magic should do the rest.
```
module "region_us_east_1" {
  source          = "./modules/vpc"
  ...
  providers = {
    aws = aws.us
  }
}
```
The only downside to this is you have to declare the modules more than once, one for each reach. Certainly more duplicated code than what Terragrunt offers. 

# Authentication
This is not a tutorial on authentication. But:
1. Open a terminal window to this directory.
2. Authenticate to your AWS account by using `aws sso login` or anything other method you prefer.
3. If you have multiple AWS accounts you will need to set your AWS_PROFILE to what-ever account you want to deploy to. For example `export AWS_PROFILE=dev`

# Terraform
4. Execute: `terraform apply`.

# Terragrunt
4. cd into the live directory
5. Execute:

For dev environment
```
AWS_REGION=us-east-1 terragrunt run-all apply --terragrunt_working_dir dev
AWS_REGION=eu-west-1 terragrunt run-all apply --terragrunt_working_dir dev
etc...
```

For qa environment
```
AWS_REGION=us-east-1 terragrunt run-all apply --terragrunt_working_dir qa
AWS_REGION=eu-west-1 terragrunt run-all apply --terragrunt_working_dir qa
etc...
```

As you can see, if you want to deploy to more regions, you only have to invoke one command per region. This certainly can cut down on the amount of duplicate terragrunt code required.