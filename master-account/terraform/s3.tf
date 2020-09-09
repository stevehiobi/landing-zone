resource "aws_s3_bucket" "landingzone_bucket" {
  bucket        = "landingzone-bucket"
  force_destroy = false
}
