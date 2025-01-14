## DEPLOY INFRASTRUCTURE TERRAFORM

This project entails the provisioning of an Ec2 instance and immdiately the instance is lunched then nginx webserver 
should be installed with the script called nginx-server in the root folder but ofcourse the necceesary security settings and firewall will be installed as well


### Projects Requirements
First download and install the terraform using this link As a first step, install terraform (see: https://www.terraform.io/downloads)) and select your machine version if its windows and if its mac you can select accordingly and install the requirements:

To check if terraform was installed
$ terraform --version

Download and run the AWS CLI MSI installer for Windows (64-bit) and add the IAM user credentails gotten from AWS the secret_key and the access_key

https://awscli.amazonaws.com/AWSCLIV2.msi

Terraform Access Provisioing and Docker requirements for this project:
I created the ec2.tf file and insert the following code snippeets below
In the code we see where the ec2 instance was created with all its componensts with region and neccessary security group ids


provider "aws" {
  
  region  = var.region

}

resource "aws_instance" "nginx-server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "devopskey2"
  vpc_security_group_ids = ["${aws_security_group.firewall.id}"]
  user_data = file("nginx-install.sh")

  

  
  
  tags = {
    Name = "nginx_server"
  }

}

Next i created the security group woith its inress and egress rules as seen below

resource "aws_security_group" "firewall" {

  name = "ayenco-security-firewall"
  
  ingress {

    cidr_blocks = ["0.0.0.0/0"]
    
    description = "http"
    
    from_port   = 80
    
    to_port     = 80
    protocol    = "tcp"


  }

  ingress {

    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"


  }

  egress {

    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"


  }
  tags = {

    Name = "Firewall"
  }

}

i also created the varibale.tf to have values and default values incorporated at run time as seen belwo

variable "ami" {

  type    = string
  
  default = "ami-0eb260c4d5475b901

}

variable "instance_type" {

  type    = string
  
  default = "t2.micro"

}
variable "region" {

  type    = string
  
  default = "eu-west-2"

}# deploy-infrastructure-terraform
