# Vulnerable: Security group con puerto 22 abierto a todo el mundo
resource "aws_security_group" "insecure_ssh" {
  name        = "insecure-ssh"
  description = "Insecure SG with SSH open to the world"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH open to all"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ❌ Vulnerable: acceso global
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "insecure-ssh"
  }
}

