

variable "instance_security_group_name" {
    description = "The name of sg for ec2"
    type = string
    default = "eks-instance"
}

variable "http_port" {
    description = "Port for HTTP requests"
    type = number
    default = 80
}

variable "https_port" {
    description = "Port for HTTPs requests"
    type = number
    default = 443
}

variable "ssh_port" {
    description = "Port for SSH requests"
    type = number
    default = 22
}

variable "rds_name" {
  description = "The SG name of the RDS"
  type        = string
  default     = "test-sg-rds"
}