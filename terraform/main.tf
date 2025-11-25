resource "aws_instance" "ubuntu-machine" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.private-link-key-1.key_name
  primary_network_interface {
    network_interface_id = aws_network_interface.service-provider-eni.id
  }
  tags = var.tags
  # user_data = file("./script.sh")
  user_data = file("${path.module}/jenkins_script.sh")
}

resource "aws_internet_gateway" "service-provider-igw" {
  vpc_id = aws_vpc.service-provider-vpc.id
  tags   = var.tags
}

resource "aws_route_table" "service-provider-public-rt" {
  vpc_id = aws_vpc.service-provider-vpc.id
  route {
    cidr_block = var.route_cidr_block
    gateway_id = aws_internet_gateway.service-provider-igw.id
  }
  tags = var.tags
}

resource "aws_subnet" "service-provider-public-subnet" {
  vpc_id                  = aws_vpc.service-provider-vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  tags                    = var.tags
}

resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.service-provider-public-subnet.id
  route_table_id = aws_route_table.service-provider-public-rt.id
}

resource "aws_network_interface" "service-provider-eni" {
  subnet_id       = aws_subnet.service-provider-public-subnet.id
  private_ips     = ["11.0.3.13"]
  security_groups = [aws_security_group.private-sg.id]
  tags            = var.tags
}

resource "aws_eip" "service-provider-eip" {
  network_interface = aws_network_interface.service-provider-eni.id
  depends_on = [
    aws_internet_gateway.service-provider-igw,
    aws_instance.ubuntu-machine
  ]
  tags = var.tags
}

# resource "aws_route_table" "service-provider-private-rt" {
#   vpc_id = aws_vpc.service-provider-vpc.id
#   route = {
#     cidr_block = "0.0.0.0/0"}
#   tags = {
#     Name  = "service-provider-private-rt"
#     Owner = "CNC-Team"
#     email = "cnc@nice.com"
#   }
# }

resource "aws_key_pair" "private-link-key-1" {
  key_name   = "private-key"
  public_key = var.public_key
  # public_key = "private-key.pub"
}

resource "aws_vpc" "service-provider-vpc" {
  cidr_block = var.cidr_block
  tags       = var.tags
}

resource "aws_security_group" "private-sg" {
  name        = "private-sg"
  description = "Security group for private link instance"
  vpc_id      = aws_vpc.service-provider-vpc.id

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

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}