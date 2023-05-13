#Enviroment variables
variable "az" {
    type = string
    default = "us-east-1a"
}

variable "region" {
    type = string
    default = "us-east-1"
}

variable "project_name" {
    type = string
    default = "final-demo"
}

variable "environment-dev" {
    type = string
    default = "dev"
}

variable "environment-prod" {
    type = string
    default = "prod"
}
#-----------------------------------

# Instance variables
variable "instance_name" {
    type = string
    default = "ubuntu_tf"
    description = "server for demo"
}

variable "instance_owner" {
    type = string
    default = "Devops stivenvr"
    description = "Instance's owner"
}
variable "instace_type" {
    type = string
    default = "t2.micro"
    description = "EC2 isntance type"
}

variable "instance_tag" {
    type = string
    default = "Amazon linux server"
    description = "EC2 isntance type"
}

variable "instance_ami" {
    type = string
    default = "ami-007855ac798b5175e"
    description = "Ami id for the instance"  
}
#-----------------------------------

#VPC variables

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_az1_cidr" {
    type = string
    default = "10.0.1.0/24"
}
#-----------------------------------

#Route table variables
variable "route_table_cidr" {
    type = string
    default = "0.0.0.0/0"
    description = "allowed route directions"
}

#Security Groups

variable "allowed_ports" {
    type = list(any)
    description = "List of allowed ports"
    default = [ "80", "443", "22", "8080" ]
  
}