variable "rg_count" {
  description = "Number of resource groups to create"
}

output "rg_locations" {
  value = [for rg in azurerm_resource_group.rg : rg.location]
}

output "rg_names" {
  value = [for rg in azurerm_resource_group.rg : rg.name]
}

variable "location" {
  description = "Location for the resource groups"
  default     = "East US"
}

resource "azurerm_resource_group" "rg" {
  count    = var.rg_count
  name     = "rg-${count.index}"
  location = var.location
}
