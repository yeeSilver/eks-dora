# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host
locals {
    
    common_tags = {
        group = "jay"
        created= timestamp()
    }
    
  
}

module "eks_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.5.0"

  name = "eks-cluster-sg"
  description = "Security Group with all port open for everybody (IPv4 CIDR), egress ports are all port open"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["all-all"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]

    tags = merge(
        {
            Name = "jay-sg"
        },
        local.common_tags
    )
}