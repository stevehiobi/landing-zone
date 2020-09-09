resource "aws_organizations_policy" "ScpDenyAll" {
    name = "scp_denyt_all"
    description = "SCP to deny access to every operation."
    content = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
POLICY

}