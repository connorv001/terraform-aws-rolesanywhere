# terraform-aws-rolesanywhere
Terraform module for rolesanywhere auto provision; it's a service that allows you to connect to on premise stuff without exposing credentials.

## "What is AWS IAM Roles Anywhere?"

AWS IAM Roles Anywhere provides temporary credentials for accessing AWS resources. It operates using X.509 certificates and PKI, where your on-premise servers use client certificates signed by a certificate authority (CA) that you control and have registered with AWS IAM Roles Anywhere. Using AWS IAM Roles Anywhere is free, however, there is a cost associated with using AWS Private CA.