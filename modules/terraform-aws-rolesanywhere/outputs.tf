resource "local_file" "cert-body" {
  sensitive_content = aws_acmpca_certificate.example.certificate
  filename          = "./body.pem"
}

resource "local_file" "cert-chain" {
  sensitive_content = aws_acmpca_certificate.example.certificate_chain
  filename          = "./certchain.txt"
}

resource "local_file" "tls_private_key" {
  sensitive_content = tls_private_key.key.private_key_pem
  filename          = "./tls_private_key.pem"
}

resource "aws_s3_bucket_object" "cert-body" {
  depends_on = [
    local_file.cert-body
  ]
  bucket = aws_s3_bucket.bucket_devops_credentials.bucket
  key    = "${var.environment}/roles-anywhere/cert-body.pem"
  source = "./body.pem"
}

resource "aws_s3_bucket_object" "cert-chain" {
  depends_on = [
    local_file.cert-chain
  ]
  bucket = aws_s3_bucket.bucket_devops_credentials.bucket
  key    = "${var.environment}/roles-anywhere/certchain.txt"
  source = "./certchain.txt"
}

resource "aws_s3_bucket_object" "tls_private_key" {
  bucket = aws_s3_bucket.bucket_devops_credentials.bucket
  depends_on = [
    local_file.tls_private_key
  ]
  key    = "${var.environment}/roles-anywhere/tls_private_key.pem"
  source = "./tls_private_key.pem"
}

output "anchor" {
  value = aws_rolesanywhere_trust_anchor.roles.arn
}

output "profile" {
  value = aws_rolesanywhere_profile.roles.arn
}

output "awsiam" {
  value = aws_iam_role.roles.arn
}


data "template_file" "example" {
  template = "${aws_rolesanywhere_trust_anchor.roles.arn}\n${aws_rolesanywhere_profile.roles.arn}\n${aws_iam_role.roles.arn}"

  vars = {
    trust_anchor_arn = aws_rolesanywhere_trust_anchor.roles.arn
    profile_arn      = aws_rolesanywhere_profile.roles.arn
    role_arn         = aws_iam_role.roles.arn
  }
}


resource "local_file" "output_arn" {
  content  = data.template_file.example.rendered
  filename = "./output.txt"
}

resource "aws_s3_bucket_object" "lcoalfile" {
  bucket = aws_s3_bucket.bucket_devops_credentials.bucket
  depends_on = [
    local_file.output_arn
  ]
  key    = "${var.environment}/roles-anywhere/output-ARNs.txt"
  source = "./output.txt"
}