resource "aws_instance" "wordpress_instance" {
  ami           = "ami-07d9b9ddc6cd8dd30"  # Replace with a  AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = {
    Name = "wordpress-instance"
  }

  provisioner "remote-exec" {
    inline = [
      # Update package repositories
      "sudo apt update",

      # Install Apache, MySQL, PHP, and other dependencies
      "sudo apt install -y apache2 mysql-server php php-mysql libapache2-mod-php php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip",

      # Download and extract WordPress
      "wget https://wordpress.org/latest.tar.gz",
      "tar -zxvf latest.tar.gz",
      "sudo mv wordpress/* /var/www/html/",

      # (Optional) Configure WordPress settings
      "sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php",
      "sudo sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/username_here/admin/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/password_here/password/g' /var/www/html/wp-config.php",
      "sudo sed -i 's/localhost/rds_endpoint/g' /var/www/html/wp-config.php",
    ]
  }
}