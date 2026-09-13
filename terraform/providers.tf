variable "subscription_id" {
  description = "Azure subscription containing the existing NorthStar resources."
  type        = string
  sensitive   = true
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}
