resource "aws_organizations_policy" "ScpFullAWS" {
    name = "scp_full_aws"
    description = "SCP to allows access to every operation."
    content = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
POLICY

}