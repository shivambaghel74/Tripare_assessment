resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.db_subnet_ids
}

resource "aws_security_group" "this" {
  name        = "${var.name}-rds-sg"
  description = "RDS accepts PostgreSQL only from ECS"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from ECS tasks"
    protocol        = "tcp"
    from_port       = var.port
    to_port         = var.port
    security_groups = [var.ecs_security_group_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.name}-postgres"

  engine         = var.engine
  instance_class = var.instance_class

  allocated_storage      = var.allocated_storage
  storage_type           = "gp3"
  storage_encrypted      = true
  publicly_accessible    = false
  multi_az               = var.multi_az
  deletion_protection    = var.deletion_protection
  backup_retention_period = var.backup_retention_period

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  skip_final_snapshot = true

  tags = {
    Name = "${var.name}-postgres"
  }
}
