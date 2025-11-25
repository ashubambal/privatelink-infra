locals {
  common_tags         = var.tags
  vpc_name            = "${var.base_name}-vpc"
  public_subnet_name  = "${var.base_name}--public-subnet-1a"
  private_subnet_name = "${var.base_name}-private-subnet-1a"
}