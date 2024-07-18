### asg ###
### 일단 보안 그룹은 생각을 좀 해보도록하자 ###
resource "aws_security_group" "jay_eks_sg" {
    vpc_id = aws_vpc.jay_eks_vpc.id
    name = var.instance_security_group_name
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "jay-tf-sg"
    }
}

