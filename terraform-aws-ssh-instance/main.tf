provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access
  secret_key = var.aws_secret
}

resource "aws_instance" "ec2_aws_instance_ssh" {

  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data              = file("${path.module}/setup-ssh.sh")
  tags = {
    Name = var.instance_name
  }
  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("C:/Users/son17/.ssh/aws_key")
    timeout     = "4m"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = var.public_key
}