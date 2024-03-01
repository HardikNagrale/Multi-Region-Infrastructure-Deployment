resource "aws_db_subnet_group" "main" {
  name        = "rds-subnet-group"  
  subnet_ids  = [var.subnet_id]
  description = "RDS subnet group for mydb" 
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  db_name              = "mydb"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "password"
  db_subnet_group_name = aws_db_subnet_group.main.name
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}