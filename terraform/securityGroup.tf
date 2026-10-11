resource "aws_security_group" "this" {
  name   = "quakewatch-sg"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  # -- My IP only
  #   cidr_blocks       = ["${trimspace(data.http.myip.response_body)}/32"]  
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = ["${trimspace(data.http.myip.response_body)}/32"]
}

resource "aws_security_group_rule" "allow_k3s_api_from_monitoring" {
  type                     = "ingress"
  from_port                = 6443
  to_port                  = 6443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = aws_security_group.monitoring.id
}

resource "aws_security_group_rule" "allow_vxlan_setup_to_node_1" {
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = aws_security_group.monitoring.id
}

# NODE 2

resource "aws_security_group" "monitoring" {
  name   = "quakewatch-monitoring-sg"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_vxlan_setup_to_node_2" {
  type                     = "ingress"
  from_port                = 8472
  to_port                  = 8472
  protocol                 = "udp"
  security_group_id        = aws_security_group.monitoring.id
  source_security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "allow_kubelet_api_to_node_2" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.monitoring.id
  source_security_group_id = aws_security_group.this.id
}