variable "org" {
  type = "string"
  description = "Name of your organization"
}

variable "unit" {
    type = string
    description = "value of the department."
}

variable "domain" {
    type = string
    description = "domain for your company"
}

variable "bucket" {
    type = string
    description = "Name of the bucket where you want to give full access to"
}

variable "bucket_creds" {
    type = string
    description = "Name of the bucket where the credentials will be stored."
}
