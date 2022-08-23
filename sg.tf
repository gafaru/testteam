resource "aws_security_group" "vmsg" {
  description = "Allow connection between ALB and target"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "int" {
  #for_each = var.ports

  security_group_id = aws_security_group.vmsg.id
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "vmhttp" {
  security_group_id = aws_security_group.vmsg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "efs" {
  #for_each = var.ports

  security_group_id = aws_security_group.vmsg.id
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "out" {
  security_group_id = aws_security_group.vmsg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
