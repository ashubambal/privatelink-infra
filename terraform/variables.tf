variable "public_key" {
  description = "Public key for AWS key pair"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "Instance tpye used for EC2 instance"
  type = string
  default = "t3.micro"
}

variable "ami" {
  description = "ami id for EC2 instance"
  type = string
  default = "ami-02b8269d5e85954ef"
}