resource "aws_organizations_policy" "ScpS3" {
    name = "scp_s3"
    description = "SCP with restrictionss for S3."
    content = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "s3:PutBucketPublicAccessBlock",
                "s3:delete"
            ],
            "Resource": "*"
        }
    ]
}
POLICY

}