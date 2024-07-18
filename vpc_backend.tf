terraform {
    backend "s3" {
        # 이전에 생성한 버킷 이름
        bucket = "jay-eks-terraform"
        key = "vpc/terraform.tfstate"
        region = "ap-northeast-2"

      
    }
  
}