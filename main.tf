
resource "aws_default_vpc" "vpc" {
  tags = {
    Name = "vpc"
  }
}

resource "aws_default_subnet" "def_subnet_a" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "def_subnet_a"
  }
}

resource "aws_default_subnet" "def_subnet_b" {
  availability_zone = "us-east-1b"
  tags = {
    Name = "def_subnet_b"
  }
}

resource "aws_security_group" "tf_ecs_SG" {
  name = "Security Group ECS"
  vpc_id = aws_default_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security group for ecs"
  }
  depends_on = [aws_default_vpc.vpc]
}

resource "aws_security_group" "tf_lb_SG" {
  name = "Security Group LB"
  vpc_id = aws_default_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security group for ecs"
  }
  depends_on = [aws_default_vpc.vpc]
}

resource "aws_lb" "demo_lb" {
    name = "demo-load-balancer"
    load_balancer_type = "application"
    internal = "false"
    security_groups = [ aws_security_group.tf_ecs_SG.id ]
    subnets = [ aws_default_subnet.def_subnet_a.id, aws_default_subnet.def_subnet_b.id ]
}

resource "aws_lb_target_group" "lb_target" {
  name = "lb-target-group"
  port = 5555
  protocol = "HTTP"
  vpc_id = aws_default_vpc.vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/status"
    unhealthy_threshold = "2"
  }
  depends_on = [ aws_lb.demo_lb ]
}

resource "aws_lb_listener" "ecs_listener" {
    load_balancer_arn = aws_lb.demo_lb.arn
    port = "5555"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.lb_target.arn
    }  
}

resource "aws_ecs_cluster" "demo_cluster" {
    name = "demo-cluster" 
    setting {
        name = "containerInsights"
        value = "enabled"
    }
}

resource "aws_ecs_task_definition" "demo_task" {
    family = "demo-task"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    memory = 512
    cpu = 256
    container_definitions = jsonencode(
        [
            {
                "name" : "demo_container",
                "image" : "public.ecr.aws/t5u9r2n7/mydemoimages:latest",
                "memory" : 512,
                "cpu" : 256,
                "essential" : true,
      
                "portMappings" : [
                    {
                        "containerPort" : 5555,
                        "hostPort" : 5555,
                        "protocol" : "tcp"
                    }
                ],
            }
        ]
    )
}

resource "aws_ecs_service" "demo_ecs_service" {
    name = "demo_ecs_service"
    cluster = aws_ecs_cluster.demo_cluster.id
    task_definition = aws_ecs_task_definition.demo_task.arn
    launch_type = "FARGATE"
    scheduling_strategy = "REPLICA"
    force_new_deployment = true
    deployment_maximum_percent = 200
    deployment_minimum_healthy_percent = 0
    desired_count = 2
    depends_on = [ aws_lb_listener.ecs_listener ]

    network_configuration {
      subnets = [ aws_default_subnet.def_subnet_a.id, aws_default_subnet.def_subnet_b.id ]
      assign_public_ip = true
      security_groups = [ aws_security_group.tf_ecs_SG.id, aws_security_group.tf_lb_SG.id ]
    }

    load_balancer {
      target_group_arn = aws_lb_target_group.lb_target.arn
      container_name = "demo_container"
      container_port = 5555
    }
    lifecycle {
      ignore_changes = [ desired_count ]
    }
}