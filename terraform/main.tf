provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example" {
  ami           = "ami-07c8c1b18ca66bb07"  # Replace with your desired AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
