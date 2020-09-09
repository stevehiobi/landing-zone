

resource "aws_organizations_policy" "ScpAllOrgs" {
    name = "scp_root_account"
    description = "This SCP restricts IAM principals from leaving organization, disabling cloudtrail and vpc flowloags and modifying billing settings and config rules "
    content = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "organizations:LeaveOrganization"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Deny",
            "Action": [
                "cloudtrail:StopLogging"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Deny",
            "Action": [
                "aws-portal:ModifyAccount",
                "aws-portal:ModifyBilling",
                "aws-portal:ModifyPaymentMethods"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            
            "Effect": "Deny",
            "Action": [
                "config:DeleteConfigRule",
                "config:DeleteConfigurationRecorder",
                "config:DeleteDeliveryChannel",
                "config:StopConfigurationRecorder"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Deny",
            "Action": [
                "guardduty:AcceptInvitation",
                "guardduty:ArchiveFindings",
                "guardduty:CreateDetector",
                "guardduty:CreateFilter",
                "guardduty:CreateIPSet",
                "guardduty:CreateMembers",
                "guardduty:CreatePublishingDestination",
                "guardduty:CreateSampleFindings",
                "guardduty:CreateThreatIntelSet",
                "guardduty:DeclineInvitations",
                "guardduty:DeleteDetector",
                "guardduty:DeleteFilter",
                "guardduty:DeleteInvitations",
                "guardduty:DeleteIPSet",
                "guardduty:DeleteMembers",
                "guardduty:DeletePublishingDestination",
                "guardduty:DeleteThreatIntelSet",
                "guardduty:DisassociateFromMasterAccount",
                "guardduty:DisassociateMembers",
                "guardduty:InviteMembers",
                "guardduty:StartMonitoringMembers",
                "guardduty:StopMonitoringMembers",
                "guardduty:TagResource",
                "guardduty:UnarchiveFindings",
                "guardduty:UntagResource",
                "guardduty:UpdateDetector",
                "guardduty:UpdateFilter",
                "guardduty:UpdateFindingsFeedback",
                "guardduty:UpdateIPSet",
                "guardduty:UpdatePublishingDestination",
                "guardduty:UpdateThreatIntelSet"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Deny",
            "Action": [
                "ec2:DeleteFlowLogs",
                "logs:DeleteLogGroup",
                "logs:DeleteLogStream"
            ],
            "Resource": "*"
        }
    ]
}
POLICY

}