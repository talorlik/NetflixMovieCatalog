terraform {
    backend "s3" {
    bucket = "alonit-tf-state-files"
    key    = "tfstate.json"
    region = "us-east-2"
    # optional: dynamodb_table = "<table-name>"
  }
}

provider "aws" {
  region = "eu-north-1"

}

resource "aws_instance" "example" {
  ami           = "ami-07c8c1b18ca66bb07"  # Replace with your desired AMI ID
  instance_type = "t3.micro"

  tags = {
    Name = "example-instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
