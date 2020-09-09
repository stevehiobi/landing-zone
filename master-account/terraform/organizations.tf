resource "aws_organizations_organization" "org" {
  count       = var.enable_organization ? 1 : 0
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "security" {
  count     = var.enable_organization ? 1 : 0
  name      = "Security"
  parent_id = aws_organizations_organization.org[0].roots[0].id
}