# VPC ID
output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.jay_eks_vpc.id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
    description = "CIDR block of the vpc"
    value = var.vpc_cidr[0]

}

# VPC Public Subnets
output "public_subnets" {
    description = "List of IDs of public subnets"
    value = var.pub_sb_cidr
  
}


output "private_subnets" {
    description = "List of IDs of private subnets"
    value = var.pvt_sb_cidr

}

#NAT gateway Public IP
output "nat_public_ips" {
    description = "List of public Elastic IPs created for AWS NAT Gateway"
    value = aws_nat_gateway.jay_eks_ngw.allocation_id
  
}


# public sunbnet_id와 pvt subnet id는 하나의 서브넷만 챙긴다 => eks 용 
output "public_subnets_id" {
    description = "List of IDs of public subnets"
    value = [aws_subnet.pub_2a_1.id, aws_subnet.pub_2a_2.id, aws_subnet.pub_2c_1.id, aws_subnet.pub_2c_2.id]
  
}

output "private_subnets_id" {
    description = "List of IDs of public subnets"
    value = [aws_subnet.pvt_2a_1.id, aws_subnet.pvt_2a_2.id, aws_subnet.pvt_2c_1.id, aws_subnet.pvt_2c_2.id]
  
}