provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "./modules/vpc"
  region  = var.region
}

module "security_groups" {
  source   = "./modules/security_groups"
  region   = var.region
  vpc_id   = module.vpc.vpc_id
}

module "ec2_instance" {
  source            = "./modules/ec2_instance"
  region            = var.region
  subnet_id         = var.subnet_id
  key_name          = var.key_name
}

module "s3_bucket" {
  source  = "./modules/s3_bucket"
  region  = var.region
}

module "rds" {
  source      = "./modules/rds"
  region      = var.region
  subnet_id   = var.subnet_id
}

module "wordpress_service" {
  source      = "./modules/wordpress_service"
  region      = var.region
  subnet_id   = var.subnet_id
  key_name    = var.key_name
}

module "alb" {
  source      = "./modules/alb"
  region      = var.region
  vpc_id      = module.vpc.vpc_id
  subnet_id   = var.subnet_id
}
