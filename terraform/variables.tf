# variable "public_key" {
#   description = "Public key for AWS key pair"
#   type        = string
#   sensitive   = true
# }

# variable "instance_type" {
#   description = "Instance tpye used for EC2 instance"
#   type        = string
#   default     = "t3.micro"
# }

# variable "ami" {
#   description = "ami id for EC2 instance"
#   type        = string
#   default     = "ami-0d176f79571d18a8f"
# }

# variable "vpc_id" {
#   description = "VPC ID where resources will be created"
#   type        = string
#   default     = "11.0.0.0/16"
# }

# variable "tags" {
#   description = "common tags for resources"
#   type        = map(string)
#   default = {
#     Owner = "devops-team"
#     email = "devops@softconsist.com"
#   }
# }

# variable "base_name" {
#   description = "Base name for resources"
#   type        = string
#   default     = "service-provider"
# }

# variable "cidr_block" {
#   description = "cidr block for VPC"
#   type        = string
#   default     = "11.0.0.0/16"
# }

# variable "route_cidr_block" {
#   description = "Route Table ID to associate with subnet"
#   type        = string
#   default     = "0.0.0.0/0"
# }

# variable "subnet_cidr_block" {
#   description = "CIDR block for the subnet"
#   type        = string
#   default     = "11.0.3.0/24"
# }