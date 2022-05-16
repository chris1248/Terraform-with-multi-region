variable "aws_region" {
  type        = string
  description = "Region to execute deployment."
}

variable "env" {
  type        = string
  description = "Name of environment being deployed."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "private_subnets" {
  type = list(object({
    az         = string
    cidr_block = string
  }))
}

variable "public_subnets" {
  type = list(object({
    az         = string
    cidr_block = string
  }))
}

