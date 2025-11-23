resource "aws_s3_bucket" "privateLink-s3" {
  bucket = "ashutsoh-privatelink-infra-terraform-state-file"
  region = "ap-south-1"
  tags = {
    Name        = "privatelink-infra-terraform-state-file"
    Environment = "Dev"
  }
}