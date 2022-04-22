variable "vcenter" {
  type        = string
  description = "vSphere IP Address"
}
variable "vcenter_password" {
  type        = string
  description = "Password to access vSphere"
}
variable "apikey" {
  type        = string
  description = "API Key"
}
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
}
variable "endpoint" {
  type        = string
  description = "API Endpoint URL"
  default     = "https://www.intersight.com"
}
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}
variable "ssh_user" {
  type        = string
  description = "SSH Username for node login."
  default     = "iksadmin"
}
variable "ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}
variable "tags" {
  type = list(map(string))
  default = [{
    "key" : "managed_by"
    "value" : "Terraform"
    },
    {
      "key" : "owner"
      "value" : "adeprato"
  }]
}
