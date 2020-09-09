resource "aws_s3_bucket" "logs" {
  bucket        = var.bucket
  force_destroy = var.force_destroy
}

data "aws_iam_policy_document" "logs_bucket_policy" {
  statement {
    sid       = "AWSAclCheck20200908"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.logs.bucket}"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite20200908"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.logs.bucket}/${var.cloudtrail_path}*"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSConfigWrite20200908"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.logs.bucket}/${var.config_path}*"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.bucket
  policy = data.aws_iam_policy_document.logs_bucket_policy.json
}