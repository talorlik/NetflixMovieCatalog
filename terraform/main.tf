provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0abcdef1234567890"  # Replace with your desired AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
