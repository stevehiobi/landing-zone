data "archive_file" "my_lambda_function_dependencies" {
  source_dir  = "${path.module}/../account-vending-machine/lambda/"
  output_path = "${path.module}/../account-vending-machine/cloudformation/AccountCreationLambda.zip"
  type        = "zip"

}

resource "random_id" "id" {
  byte_length = 8
}

resource "aws_s3_bucket_object" "lambda_code" {
  key    = "${random_id.id.hex}-object"
  bucket = aws_s3_bucket.landingzone_bucket.id
  source = data.archive_file.my_lambda_function_dependencies.output_path
  etag   = data.archive_file.my_lambda_function_dependencies.output_base64sha256
}

resource "aws_lambda_function" "example" {
  function_name = "AccountBuilderLambda"
  handler       = "AccountCreationLambda.main"
  runtime       = "python3.6"

  s3_bucket = aws_s3_bucket.landingzone_bucket.id
  s3_key    = aws_s3_bucket_object.lambda_code.id

  role = aws_iam_role.lambda_access_role.arn

  source_code_hash = data.archive_file.my_lambda_function_dependencies.output_base64sha256
}

resource "aws_iam_role" "lambda_access_role" {
  name = "LambdaAccessRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
