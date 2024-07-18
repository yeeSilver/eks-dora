# 테라폼 - aws 인프라 
provider "aws" {
    region = var.vpc_region
}

locals {
    
    common_tags = {
        group = "jay"
        created= timestamp()
    }
    
  
}

data "aws_availability_zones" "available"{
    state = "available"
}

## vpc, subnet ## 
resource "aws_vpc" "jay_eks_vpc"{
    cidr_block = var.vpc_cidr[0]  
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy =  "default"

    tags = merge(
        {
            Name = "jay-eks-vpc"
        },
        local.common_tags
    )
    
}



resource "aws_subnet" "pub_2a_1" {
    vpc_id = aws_vpc.jay_eks_vpc.id
    cidr_block = var.pub_sb_cidr[0]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = merge(
        {
            Name = "jay-eks-pub-2a-1"
        },
        local.common_tags
    )

  
}

resource "aws_subnet" "pub_2a_2" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pub_sb_cidr[1]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = merge(
        {
            Name = "jay-eks-pub-2a-2"
        },
        local.common_tags
    )
}
resource "aws_subnet" "pub_2c_1" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pub_sb_cidr[2]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[2]
    tags = merge(
        {
            Name = "jay-eks-pub-2c-1"
        },
        local.common_tags
    )
}

resource "aws_subnet" "pub_2c_2" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pub_sb_cidr[3]
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[2]
    tags = merge(
        {
            Name = "jay-eks-pub-2c-2"
        },
        local.common_tags
    )
}

resource "aws_subnet" "pvt_2a_1" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pvt_sb_cidr[0]
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = merge(
        {
            Name = "jay-eks-pvt-2a-1"
        },
        local.common_tags
    )
}

resource "aws_subnet" "pvt_2a_2" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pvt_sb_cidr[1]
    availability_zone = data.aws_availability_zones.available.names[0]
    tags = merge(
        {
            Name = "jay-eks-pvt-2a-2"
        },
        local.common_tags
    )
}

resource "aws_subnet" "pvt_2c_1" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pvt_sb_cidr[2]
    availability_zone = data.aws_availability_zones.available.names[2]
    tags = merge(
        {
            Name = "jay-eks-pvt-2c-1"
        },
        local.common_tags
    )
}

resource "aws_subnet" "pvt_2c_2" {
    vpc_id =  aws_vpc.jay_eks_vpc.id
    cidr_block = var.pvt_sb_cidr[3]
    availability_zone = data.aws_availability_zones.available.names[2]
    tags = merge(
        {
            Name = "jay-eks-pvt-2c-2"
        },
        local.common_tags
    )
}

## IGW, NGW, RT, Attachment ##
resource "aws_internet_gateway" "jay_eks_igw" {
    vpc_id = aws_vpc.jay_eks_vpc.id

    tags = merge(
        {
            Name = "jay-eks-igw"
        },
        local.common_tags
    )
}

resource "aws_eip" "ngw" {
  
}

resource "aws_nat_gateway" "jay_eks_ngw" {
    allocation_id = aws_eip.ngw.id
    subnet_id = aws_subnet.pub_2a_1.id

    tags = merge(
        {
            Name = "jay-eks-ngw"
        },
        local.common_tags
    )
}

resource "aws_route_table" "pub_rtb" {
    vpc_id = aws_vpc.jay_eks_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jay_eks_igw.id
    }

    tags = merge(
        {
            Name = "jay-eks-pub-rtb"
        },
        local.common_tags
    )
}

resource "aws_route_table" "pvt_rtb" {
    vpc_id = aws_vpc.jay_eks_vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.jay_eks_ngw.id
    }

    tags = merge(
        {
            Name = "jay-eks-pvt-rtb"
        },
        local.common_tags
    )
  
}

resource "aws_route_table_association" "pub_2a-1_association" {
    subnet_id = aws_subnet.pub_2a_1.id
    route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_route_table_association" "pub_2a-2_association" {
    subnet_id = aws_subnet.pub_2a_2.id
    route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_route_table_association" "pub_2c-1_association" {
    subnet_id = aws_subnet.pub_2c_1.id
    route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_route_table_association" "pub_2c-2_association" {
    subnet_id = aws_subnet.pub_2c_2.id
    route_table_id = aws_route_table.pub_rtb.id
}

resource "aws_route_table_association" "pvt_2a_1" {
    subnet_id =  aws_subnet.pvt_2a_1.id
    route_table_id = aws_route_table.pvt_rtb.id
  
}

resource "aws_route_table_association" "pvt_2a_2" {
    subnet_id =  aws_subnet.pvt_2a_2.id
    route_table_id = aws_route_table.pvt_rtb.id
  
}

resource "aws_route_table_association" "pvt_2c_1" {
    subnet_id =  aws_subnet.pvt_2c_1.id
    route_table_id = aws_route_table.pvt_rtb.id
  
}

resource "aws_route_table_association" "pvt_2c_2" {
    subnet_id =  aws_subnet.pvt_2c_2.id
    route_table_id = aws_route_table.pvt_rtb.id
  
}

