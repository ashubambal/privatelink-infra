resource "aws_instance" "ubuntu-machine" {
  ami           = "ami-02b8269d5e85954ef" # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_type = "t3.micro"
  key_name      = aws_key_pair.private-link-key-1.key_name
  tags = {
    Name = "UbuntuInstance"
  }
}

resource "aws_key_pair" "private-link-key-1" {
  key_name   = "private-key"
  public_key = file("C:\\Users\\Admin\\Desktop\\Ashutsoh\\Git\\privatelink-infra\\terraform\\private-key.pub")

}