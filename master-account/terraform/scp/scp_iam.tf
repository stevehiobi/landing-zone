resource "aws_organizations_policy" "ScpIAM" {
    name = "scp_iam"
    description = "SCP with restrictionss for IAM."
    content = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Deny",
        "Action": [
            "iam:CreateAccessKey",
            "iam:CreateUser"
        ],
        "Resource": "*"
    }
}
POLICY

}