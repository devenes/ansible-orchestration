provider "aws" {
  region = "us-east-2" # Define the region where the resource will be created
}

variable "vpc_id" {
  type    = string
  default = "vpc-02ca20d6c9bae6b3c" # Define your VPC ID
}

variable "instance_type" {
  type    = string
  default = "t2.micro" # Define your instance type
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true # Find the most recent AMI

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_instance" "enes_web_server" { # define EC2 details to create
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type # You need to use "var" to define variables in Terraform
  key_name      = "ssh1"            # Define your existing key pair here

  tags = {
    Name = "Terraform-Test-Instance"
  }
}

output "test" {
  value = data.aws_ami.amazon-linux-2
}
