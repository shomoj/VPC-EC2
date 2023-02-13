terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
  /*
  backend "s3" {
    bucket         = "bootcamp29-2-shola"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}


resource "aws_kms_key" "mykey" {
  description             = "kmskey2"
  deletion_window_in_days = 30
  tags = {
    Name = "kms-statefile2"
  }
}


resource "aws_s3_bucket" "mybucket" {
  bucket = "bootcamp29-2-shola"
}

resource "aws_s3_bucket_acl" "mybucket" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "private"
}



resource "aws_s3_bucket_versioning" "versioning_mybucket" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
*/


resource "aws_dynamodb_table" "tf_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  read_capacity  = 3
  write_capacity = 3
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform Lock Table"
  }
  lifecycle {
   prevent_destroy = false
  }
 }


# Provider Block
provider "aws" {
  region  = "us-east-1"
  profile = "sholade1"
}
