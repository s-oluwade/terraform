provider "aws" {
  region = "us-east-1"  # or your preferred region
}

resource "aws_instance" "jenkins_server" {
  ami                         = "ami-05dad700d552490e4"  # your custom Jenkins AMI
  instance_type               = "t2.medium"
  key_name                    = "master-key"
  vpc_security_group_ids      = ["sg-0b6e737decdafe101"]
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins-Server-From-Custom-AMI"
  }
}

# resource "aws_eip" "jenkins_eip" {
#   instance = aws_instance.jenkins.id
#   depends_on = [aws_instance.jenkins_server]
# }