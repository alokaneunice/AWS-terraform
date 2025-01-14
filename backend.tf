terraform {
  backend "s3" {
    bucket = "caro-23345554656787"
    key    = "nginx-backend/terraform.tfstate"
    region = "us-east-2"
  }
}
