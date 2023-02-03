

resource "aws_rolesanywhere_trust_anchor" "roles" {
  name    = "roles"
  enabled = true
  source {
    source_data {
      acm_pca_arn = aws_acmpca_certificate_authority.roles.arn
    }
    source_type = "AWS_ACM_PCA"
  }
  # Wait for the ACMPCA to be ready to receive requests before setting up the trust anchor
  depends_on = [aws_acmpca_certificate.example]
}

resource "aws_rolesanywhere_profile" "roles" {
  enabled   = true
  name      = "roles"
  role_arns = [aws_iam_role.roles.arn]
}