## DEPLOY INFRASTRUCTURE TERRAFORM

This project entails the provisioning of an Ec2 instance and immdiately the instance is launched then nginx webserver 
should be installed with the script called nginx-server in the root folder but ofcourse the necceesary security settings and firewall will be installed as well

### Project prerequisite
i.Ensure Terraform is installed 
terraform --version
Terraform v1.10.3
ii. Ensure you have AWS CLI so that you can interact with AWS infrastructure 
 aws --version
aws-cli/2.22.19 Python/3.12.6 Windows/10 exe/AMD64
iii. ensure you are authenticated within AWS
aws s3 ls
2025-01-09 21:46:20 terraform764210975
iv. If not authenticated,create AWS IAM user (with administrative access)
v.The user created must be given a secret_key and an access_key
vi. To authenticate with AWS Infrastructure,
aws configure
AWS Access Key ID [****************BM4R]: 
AWS Secret Access Key [****************5n/H]: 
Default region name [eu-west-2]: 
Default output format [json]: 

vii. Run the command below to confirm  authentication with aws
aws s3 ls

aws sts get-caller-identity



### Projects Requirements
First download and install the terraform using this link As a first step, install terraform (see: https://www.terraform.io/downloads) and select your machine version if its windows and if its mac you can select accordingly and install the requirements:

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

### Process of running the project
i. To initialise the terraform backend, run the command below

terraform init
ii. To format the terraform script
terraform fmt
iii. To validate code,
terraform validate
iv. To show all the resources to be created by terraform

terraform plan
v. To create or provision the resources in aws without prompt for approval

terraform apply --auto-approve

vi.To destroy the resources created in aws without prompt for approval

terraform destroy --auto-approve

vii.Check physically in aws, all the resources have been removed