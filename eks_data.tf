data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
      bucket = "jay-eks-terraform"
      key = "vpc/terraform.tfstate"
      region = "ap-northeast-2"
    }


  
}
