resource "aws_instance" "tetris_instance" {
  ami           = "ami-0fa399d9c130ec923"  # Choose a suitable Amazon Machine Image (AMI)
  instance_type = "t2.micro"           # Choose an appropriate instance type
  #key_name      = "tetris.pem"  # Replace with your key pair name
  subnet_id     = "subnet-0d32a9e33fc71e5fc"     # Replace with your subnet ID
  associate_public_ip_address = true

user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd

              # Configure and start the Apache web server
              systemctl start httpd
              systemctl enable httpd

              # Download and deploy the Tetris game code
              git clone https://github.com/yourusername/tetris-game.git /var/www/html

              # Additional configuration for your game (e.g., database setup, environment variables, etc.)
              # ...

              # Restart Apache to apply changes
              systemctl restart httpd
              EOF
}
resource "aws_security_group" "tetris_sg" {
  name        = "tetris-sg"
  description = "Tetris Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }
  /*resource "aws_route53_zone" "al_dulaimi_com" {
  name = "al-dulaimi.com"
}

resource "aws_route53_record" "al_dulaimi_com" {
  zone_id = aws_route53_zone.al_dulaimi_com.zone_id
  name    = "al-dulaimi.com"
  type    = "A"
  ttl     = "300"
  #records = [module.tetris.instance_public_ip]
}

  # ... (other resource definitions)

output "instance_public_ip" {
  value = aws_instance.tetris_instance.public_ip
}*/



