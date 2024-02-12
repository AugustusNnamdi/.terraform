variable "users" {
  description = "Map of users and their roles"
}

# Input variables to get resource group details from the calling module
variable "resource_group_locations" {
  description = "Locations of the resource groups"
}

variable "resource_group_names" {
  description = "Names of the resource groups"
}

resource "azurerm_user_assigned_identity" "user" {
  count               = length(var.users)
  name                = "${keys(var.users)[count.index]}"
  location            = var.resource_group_locations[count.index]
  resource_group_name = var.resource_group_names[count.index]
}

resource "azurerm_role_assignment" "user_permissions" {
  count               = length(var.users)
  principal_id        = azurerm_user_assigned_identity.user[count.index].id
  role_definition_name = var.users[keys(var.users)[count.index]].role
  scope               = azurerm_user_assigned_identity.user[count.index].id
}
