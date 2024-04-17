variable "resource_group_name" {
    type = string
    description = "RG name in the azure"
  
}

variable "location" {
    type = string
    description = "RG location name in the azure"
  
}

variable "keyvault_name" {
    type = string
    description = "keyvaul_name in azure"
  
}

variable "secret_name" {
  type = string
  description = "secret_name in azure"
  }

  variable "secret_value" {
    type = string
    description = "secret_value in azure"
    sensitive = true
    
  }
