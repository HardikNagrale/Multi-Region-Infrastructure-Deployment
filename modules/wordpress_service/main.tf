module "ec2_instance" {
  source      = "../ec2_instance"
  region      = var.region
  subnet_id   = var.subnet_id
  key_name    = var.key_name
}

module "rds" {
  source      = "../rds"
  region      = var.region
  subnet_id   = var.subnet_id
}