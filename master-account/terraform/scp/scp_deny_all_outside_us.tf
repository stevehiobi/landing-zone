resource "aws_organizations_policy" "ScpS3" {
    name = "scp_s3"
    description = "SCP with restrictionss for S3."
    content = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyAllOutsideEU",
            "Effect": "Deny",
            "NotAction": [
                "a4b:*",
                "budgets:*",
                "ce:*",
                "chime:*",
                "cloudfront:*",
                "cur:*",
                "globalaccelerator:*",
                "health:*",
                "iam:*",
                "importexport:*",
                "mobileanalytics:*",
                "organizations:*",
                "route53:*",
                "shield:*",
                "support:*",
                "trustedadvisor:*",
                "waf:*",
                "wellarchitected:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "us-east-1"
                    ]
                }
            }
        }
    ]
}
POLICY

}