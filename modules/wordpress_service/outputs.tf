output "wordpress_instance_id" {
  value = module.ec2_instance.ec2_instance_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}