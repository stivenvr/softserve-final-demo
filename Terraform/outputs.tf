output "ec2_public_ip" {
    value = aws_instance.ubuntu_tf.public_ip
}

output "ec2_ami" {
    value = aws_instance.ubuntu_tf.ami
}

output "ec2_type" {
    value = aws_instance.ubuntu_tf.instance_type
}

output "public_vpc_id" {
    value = aws_vpc.vpc.id  
}

output "ec2_subnet_id" {
    value = aws_subnet.public_subnet_az1.id
}

output "ec2_subnet_az" {
    value = aws_subnet.public_subnet_az1.availability_zone
}

output "region" {
    value = data.aws_region.current.name
}