resource "aws_s3_bucket" "roles" {
  # count  = aws_s3_bucket.roles.id == [] ? 1 : 0
  bucket = var.bucket_name
}


resource "aws_s3_bucket" "bucket_devops_credentials" {
  # count  = aws_s3_bucket.bucket_devops_credentials.id == [] ? 1 : 0
  bucket = var.bucket_devops_credentials
}