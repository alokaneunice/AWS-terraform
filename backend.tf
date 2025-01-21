terraform {
  backend "s3" {
    bucket = "terraform764210975"
    key    = "nginx-backend/terraform.tfstate"
    region = "eu-west-2"
  }
}
