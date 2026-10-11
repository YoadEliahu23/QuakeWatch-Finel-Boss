resource "aws_instance" "k3s" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  subnet_id     = module.vpc.public_subnets[0]

  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true

  user_data = file("install-k3s.sh")

  tags = {
    Name = "quakewatch-k3s"
  }

  key_name = aws_key_pair.k3s.key_name
}

resource "aws_key_pair" "k3s" {
  key_name   = "quakewatch-k3s-key"
  public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

# NODE 2

resource "aws_instance" "monitoring" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "c7i-flex.large"
  subnet_id     = module.vpc.public_subnets[1]

  iam_instance_profile = aws_iam_instance_profile.quakewatch_monitoring.name

  vpc_security_group_ids      = [aws_security_group.monitoring.id]
  associate_public_ip_address = true

  tags = {
    Name = "quakewatch-monitoring"
  }

  key_name = aws_key_pair.k3s.key_name
}