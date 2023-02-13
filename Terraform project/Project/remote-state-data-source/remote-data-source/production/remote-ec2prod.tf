
terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }



backend "s3" {
    bucket         = "bootcamp29-2-shola"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
}
}




# Provider Block
provider "aws" {
  region  = "us-east-1"
  profile = "sholade1"
}

data "terraform_remote_state" "business" {
  backend = "s3"
  config = {
    bucket = "bootcamp29-2-shola"
    key    = "global/terraform.tfstate"
    region = "us-east-1"
  }
}


/*data "terraform_remote_state" "business" {
  backend = "local"
  config = {
      path    = "../remote-data-source/terraform.tfstate"
  }
}*/

resource "aws_instance" "ec2bus" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.business.outputs.private_subnets[1]

  tags = {
    "Name" = "ec2bus"
}
}
