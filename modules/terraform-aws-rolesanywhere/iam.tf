resource "aws_iam_role" "roles" {
  name = "roles"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "sts:AssumeRole",
        "sts:TagSession",
        "sts:SetSourceIdentity"
      ]
      Principal = {
        Service = "rolesanywhere.amazonaws.com",
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

resource "aws_iam_policy" "s3_full_access" {
  name        = "s3_full_access22"
  path        = "/"
  description = "Allows full access to a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:*"
      ]
      Resource = [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*"
      ]
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "roles_s3_full_access" {
  role       = aws_iam_role.roles.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}

