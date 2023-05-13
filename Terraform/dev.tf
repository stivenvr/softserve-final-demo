# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.environment-dev}-vpc"
  }
}

# use data source to get all avalablility zones in region
data "aws_region" "current" {}

# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment-dev}-public-az1"
  }
  depends_on = [ aws_vpc.vpc ]
}


# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment-dev}-igw"
  }
  depends_on = [ aws_vpc.vpc ]
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment-dev}-public-rt"
  }
  depends_on = [ aws_internet_gateway.internet_gateway ]
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_rt_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
  
  depends_on = [ aws_subnet.public_subnet_az1, aws_route_table.public_route_table ]
}

resource "aws_instance" "ubuntu_tf" {
    ami = var.instance_ami
    instance_type = var.instace_type
    subnet_id = aws_subnet.public_subnet_az1.id
    vpc_security_group_ids = [ aws_security_group.tf_SG.id ]
    user_data = <<-EOF
    #!/bin/bash
    apt apt update -y
    apt apt install httpd -y
    echo "<h2>WebServer</h2><br>Build by Terraform!"  >  /var/www/html/index.html
    sudo service httpd start
    chkconfig httpd on
    EOF
    tags = {
        Name = var.instance_name
        Owner = var.instance_owner
    }
}

/* # create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = 
  cidr_block              = 
  availability_zone       = 
  map_public_ip_on_launch = 

  tags = {
    Name = "${}-${}-private-app-az1"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = 
  cidr_block              = 
  availability_zone       = 
  map_public_ip_on_launch = 

  tags = {
    Name = "${}-${}-private-data-az1"
  }
} */

# create security group
resource "aws_security_group" "tf_SG" {
  name        = "Security Group using Terraform"
  description = "Security Group using Terraform"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment-dev}-tf_SG"
  }
}