resource "aws_key_pair" "demo" {
  key_name   = "${var.prefix}-key"
  public_key = var.public_key
}

resource "aws_instance" "app_vm" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.open_sg.id]
  key_name               = aws_key_pair.demo.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              docker run -d -p 80:8080 --name insecure-app your-dockerhub-user/insecure-app:latest
              EOF

  tags = { Name = "${var.prefix}-vm" }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

