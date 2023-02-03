resource "tls_private_key" "roles" {
  algorithm = "RSA"
}

resource "tls_cert_request" "roles" {
  private_key_pem = tls_private_key.roles.private_key_pem
  subject {
    common_name         = var.common_name
    organization        = var.organization
    organizational_unit = var.organizational_unit
  }
}
