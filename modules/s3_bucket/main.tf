resource "aws_s3_bucket" "main" {
  bucket = "my-bucket"  # Replace with your desired bucket name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.main.bucket
}