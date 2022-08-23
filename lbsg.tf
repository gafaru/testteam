resource "aws_security_group" "dev_sg" {
  description = "Allow connection Devs to ALB"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "https" {
  #for_each = var.ports

  security_group_id = aws_security_group.dev_sg.id
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "http" {
  #for_each = var.ports

  security_group_id = aws_security_group.dev_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/8"]
}
