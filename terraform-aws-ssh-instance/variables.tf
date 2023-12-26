variable "aws_access" {
  description = "aws access key"
  default     = "AKIAS5PQTLQPUJPWQ5MM"
}
variable "aws_secret" {
  description = "aws secret key"
  default     = "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"
}

variable "ami_id" {
  description = "ami id"
  default     = "ami-027a754129abb5386"
}

variable "instance_name" {
  description = "instance name"
  default     = "instanceSsh"
}

variable "public_key" {
  description = "public key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfffQCggAPQi+8e1FkAj6gKc2z6fjMJj5/ZLhN47z3cgNmZ87eXkKByOmNQ4I19MsV2bGHYYhsUpNBYriDaVP9Zulxd6/0aMPNyuHXlMr07kVGi80SYqyq62OK/tPjRXM3CCfn8ibUP7PVqMlfEs28jBsAlqp5H9YGdQWDMmn5Np5fwZWw+dsc+k1oRKqgSZj03QjpozoipL9PR2VVtUpf7kndms+fdmjoTV9DMQF8YQGzRRq1Acu92yj1l099e5DMDwLJnvLO1XM4KZ0/ydBzD28ixtZ5AioCq6aaieUNO13rxxMPjUrf7NFgb5YxangOicypNMbZatup/TZXzZM6P18Se1fV4hslXTig5hxwrf152ICJ28xodE8Vl5ZeMZ+oojTkrAHlA635wusoQqqwf+BvkIV1C+7oe09olBHjqOvVyJECT/cUHs2jot14P+gD5eS36KezxpSLWKKm4HUpvdc3oOuuU5HIlUtMPNdpcI6I4mKA97CHdCP1HH9ioK8= sondev@sondev"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "example-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}