variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault."
  default     = "dapr-architecture-test"
}

variable "location" {
  type        = string
  description = "The location/region where the Key Vault will be created."
  default     = "switzerlandnorth"
}

variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault."
  default     = "daprkvricopegnate"
}

variable "key_vault_sku_name" {
  type        = string
  default     = "standard"
  description = "The name of the SKU used to purchase Key Vault. Possible values are standard and premium."
}
