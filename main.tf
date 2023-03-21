variable "awsprops" {
    type = map(string)
    default = {
    region = "ap-south-1"
    vpc = "vpc-0beb45bf5a5c8ee37"
    ami = "ami-0f8ca728008ff5af4"
    itype = "t2.micro"
    subnet = "subnet-0ff3b4a0186fdc235"
    publicip = true
    keyname = "nexuskey"
    secgroupname = "IAC-Sec-Group"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
  access_key = "AKIA2O2OMWUCMZH2WYHB"
  secret_key = "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"
}

resource "aws_security_group" "project-iac-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "project-iac" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }
}

output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}