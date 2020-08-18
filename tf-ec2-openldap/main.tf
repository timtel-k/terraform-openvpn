provider "aws" {
  region = var.region
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_security_group" "ldap" {
  name        = "${var.name}-sg"
  description = "SSH + OpenLDAP"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 389
    to_port     = 389
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ldap" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = ["${aws_security_group.ldap.id}"]
  key_name                    = var.ssh_key_name
  subnet_id                   = var.subnet_id
  user_data                   = data.template_cloudinit_config.config.rendered

  tags = {
    Name = var.name
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #!/bin/bash
    apt-get update

    EOF
  }
}

# resource "aws_route53_record" "ldap" {
#   zone_id = var.host_route_53_zone_id
#   name    = var.host_name
#   type    = "A"
#   ttl     = "300"
#   records = ["${aws_instance.ldap.public_ip}"]
# }