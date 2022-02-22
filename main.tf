provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key=  "" 
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
}

resource "aws_vpc" "developmentvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name: "development"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.developmentvpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = "us-east-1a"
    tags = {
        Name : "subnet-dev-1"
    }
}

data "aws_vpc" "existing_vpc"{
    default =true 
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id= data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "us-east-1a"
    tags = {
        Name : "subnet-dev-default"
    }
}
