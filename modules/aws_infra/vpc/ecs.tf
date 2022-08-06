resource "aws_ecs_cluster" "my-web-cluster" {
  name = "${var.environment}-ecs"
}

resource "aws_ecs_cluster_capacity_providers" "my-web-cluster" {
  cluster_name = aws_ecs_cluster.my-web-cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}


resource "aws_ecs_task_definition" "my-web" {
  family                   = "service"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "my-web-api"
      image     = "nginx:latest"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}



resource "aws_ecs_service" "my-web-service" {
  name            = "my-web-service"
  cluster         = aws_ecs_cluster.my-web-cluster.id
  task_definition = aws_ecs_task_definition.my-web.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private_subnet.*.id
    security_groups  = [aws_security_group.default.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my-web-tg.arn
    container_name   = "my-web-api"
    container_port   = 80
  }

}
