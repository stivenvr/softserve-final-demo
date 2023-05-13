resource "aws_instance" "ubuntu_tf-prod" {
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