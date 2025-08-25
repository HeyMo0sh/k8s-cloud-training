variable "appId" {
  description = "AKS service principal clientId (ARM appId)"
  type        = string
}

variable "password" {
  description = "AKS service principal clientSecret"
  type        = string
}
