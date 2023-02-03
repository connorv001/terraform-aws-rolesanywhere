resource "aws_acmpca_certificate_authority" "roles" {
  permanent_deletion_time_in_days = 7
  type                            = "ROOT"
  certificate_authority_configuration {
    key_algorithm     = "RSA_2048"
    signing_algorithm = "SHA256WITHRSA"
    subject {
      common_name         = var.common_name
      organization        = var.organization
      organizational_unit = var.organizational_unit
    }
  }
}

data "aws_partition" "current" {}

resource "aws_acmpca_certificate" "roles" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.roles.arn
  certificate_signing_request = aws_acmpca_certificate_authority.roles.certificate_signing_request
  signing_algorithm           = "SHA256WITHRSA"

  template_arn = "arn:${data.aws_partition.current.partition}:acm-pca:::template/RootCACertificate/V1"

  validity {
    type  = "YEARS"
    value = 1
  }
}

resource "aws_acmpca_certificate_authority_certificate" "roles" {
  certificate_authority_arn = aws_acmpca_certificate_authority.roles.arn
  certificate               = aws_acmpca_certificate.roles.certificate
  certificate_chain         = aws_acmpca_certificate.roles.certificate_chain
}


resource "aws_acmpca_certificate" "example" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.roles.arn
  certificate_signing_request = tls_cert_request.csr.cert_request_pem
  signing_algorithm           = "SHA256WITHRSA"
  validity {
    type  = "DAYS"
    value = 7
  }
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "tls_cert_request" "csr" {
  private_key_pem = tls_private_key.key.private_key_pem

  subject {
    common_name = "example"
  }
}