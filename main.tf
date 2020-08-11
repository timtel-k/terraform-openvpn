provider "aws" {
  region                  = var.region
  shared_credentials_file = "/home/tt/.aws/credentials"
}

resource "aws_security_group" "openvpn" {
  name        = "${var.name}-sg"
  description = "SSH + OpenVPN"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 943
    to_port     = 943
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "udp"
    from_port   = 1194
    to_port     = 1194
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "openvpn" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = ["${aws_security_group.openvpn.id}"]
  key_name                    = var.ssh_key_name
  subnet_id                   = var.subnet_id

  tags = {
    Name = var.name
  }
}

resource "aws_route53_record" "openvpn" {
  zone_id = var.host_route_53_zone_id
  name    = var.host_name
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.openvpn.public_ip}"]
}