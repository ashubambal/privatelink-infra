resource "aws_instance" "ubuntu-machine" {
  ami                    = "ami-02b8269d5e85954ef" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.private-link-key-1.key_name
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  tags = {
    Name = "UbuntuInstance"
  }
}

resource "aws_key_pair" "private-link-key-1" {
  key_name   = "private-key"
  public_key = file("C:\\Users\\Admin\\Desktop\\Ashutsoh\\Git\\privatelink-infra\\terraform\\private-key.pub")

}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "private-sg" {
  name        = "private-sg"
  description = "Security group for private link instance"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

  