terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.91.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create three resource groups
module "resource_groups" {
  source = "./modules/resource_groups"
  rg_count = 3
}

# Create user-assigned managed identity
module "user_assigned_identity" {
  source                   = "./modules/user_assigned_identity"
  users                    = var.users
  resource_group_locations = module.resource_groups.rg_locations
  resource_group_names     = module.resource_groups.rg_names
}
