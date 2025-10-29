# Vulnerable: Instancia EC2 con credenciales en user_data
resource "aws_instance" "insecure_instance" {
  ami           = "ami-1234567890abcdef0"
  instance_type = "t2.micro"
  key_name      = "insecure-key"

  user_data = <<-EOF
              #!/bin/bash
              echo "DB_PASSWORD=supersecret123" >> /etc/environment
              EOF

  tags = {
    Name = "insecure-instance"
  }
}

