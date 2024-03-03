resource "aws_db_instance" "zoeencloudRDS" {
  allocated_storage      = 20
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  identifier             = "zoeencloud-rds"
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = true
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.romia-subnet-group.name
  vpc_security_group_ids = [aws_security_group.RDS_SG.id]  # Attach RDS security group
}