resource "aws_security_group" "open_sg" {
  name        = "${var.prefix}-open-sg"
  description = "Open SG for demo"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    description = "Allow all TCP"
    from_port   = 0
    to_port     = 65535
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

