


variable "vpc_region" {
    description = "VPC region"
    type = string
    default = "ap-northeast-2"
  
}


# vpc, subnet ip 대역
variable "vpc_cidr" {
    default = ["10.130.0.0/16"]
    type = list(string)
}
variable "pub_sb_cidr" {
    default = ["10.130.0.0/24","10.130.1.0/24","10.130.2.0/24","10.130.3.0/24"]
    type = list(string)
  
}
variable "pvt_sb_cidr" {
    default = ["10.130.4.0/24", "10.130.5.0/24", "10.130.6.0/24", "10.130.7.0/24"]
    type = list(string)
  
}
