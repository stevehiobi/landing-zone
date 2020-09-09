resource "aws_organizations_policy" "ScpEC2" {
    name = "scp_ec2"
    description = "SCP with restrictionss for EC2 instances."
    content = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "ec2:RunInstances"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "ec2:InstanceType": "t3.micro"
                }
            }
        }
    ]
}
POLICY

}