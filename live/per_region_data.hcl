locals {
  complex = {
    "us-east-1" = {
      region     = "us-east-1"
      cidr_block = "5.0.0.0/24"
      private_subnets = [
        {
          az         = "a"
          cidr_block = "5.0.0.0/26"
        },
        {
          az         = "b"
          cidr_block = "5.0.0.64/26"
        },
        {
          az         = "c"
          cidr_block = "5.0.0.128/26"
        },
        {
          az         = "d"
          cidr_block = "5.0.0.192/26"
        }
      ]
      public_subnets = [
        {
          az         = "a"
          cidr_block = "5.0.0.0/26"
        },
        {
          az         = "b"
          cidr_block = "5.0.0.64/26"
        },
        {
          az         = "c"
          cidr_block = "5.0.0.128/26"
        },
        {
          az         = "d"
          cidr_block = "5.0.0.192/26"
        }
      ]
    }
    "eu-west-1" = {
      region     = "eu-west-1"
      cidr_block = "6.0.0.0/24"
      private_subnets = [
        {
          az         = "a"
          cidr_block = "6.0.0.0/26"
        },
        {
          az         = "b"
          cidr_block = "6.0.0.64/26"
        },
        {
          az         = "c"
          cidr_block = "6.0.0.128/26"
        },
        {
          az         = "d"
          cidr_block = "6.0.0.192/26"
        }
      ]
      public_subnets = [
        {
          az         = "a"
          cidr_block = "6.0.0.0/26"
        },
        {
          az         = "b"
          cidr_block = "6.0.0.64/26"
        },
        {
          az         = "c"
          cidr_block = "6.0.0.128/26"
        },
        {
          az         = "d"
          cidr_block = "6.0.0.192/26"
        }
      ]
    }
  }
}
