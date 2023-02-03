module "roles-anywhere" {
    source = "./modules/terraform-aws-rolesanywhere"
  organization              = var.org
  organizational_unit       = var.unit
  common_name               = var.domain

  ### BUCKETS WILL BE CREATED - If you want to use existing bucket, please contact me. 
  bucket_name               = var.bucket #Name of the bucket where you want to give full access to.
  bucket_devops_credentials = var.bucket_creds # Name of the bucket where the credentials will be stored.
    
}