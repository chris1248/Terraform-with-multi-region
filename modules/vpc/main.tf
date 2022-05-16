
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "Testing"
    Region = var.aws_region
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  // Same ingress and egress rules AWS provides by default.
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Testing"
    Region = var.aws_region
  }
}


// Create multiple private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  cidr_block        = var.private_subnets[count.index].cidr_block
  availability_zone = "${var.aws_region}${var.private_subnets[count.index].az}"
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "Testing-${var.env}-internal-${var.private_subnets[count.index].az}"
  }

  lifecycle {
    ignore_changes = [tags_all]
  }
}

// Create multiple public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  cidr_block              = var.public_subnets[count.index].cidr_block
  availability_zone       = "${var.aws_region}${var.public_subnets[count.index].az}"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "Testing-${var.env}-public-${var.public_subnets[count.index].az}"
  }

  lifecycle {
    ignore_changes = [tags_all]
  }
}

