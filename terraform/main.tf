data "azurerm_resource_group" "northstar" {
  name = "NorthStar-Azure-RG"
}

resource "azurerm_user_assigned_identity" "northstar_app" {
  name                = "NorthStar-App-Identity"
  location            = data.azurerm_resource_group.northstar.location
  resource_group_name = data.azurerm_resource_group.northstar.name

  tags = {
    DataClassification = "Internal"
  }
}

output "managed_identity_name" {
  description = "Name of the managed workload identity."
  value       = azurerm_user_assigned_identity.northstar_app.name
}

resource "azurerm_role_assignment" "northstar_app_reader" {
  scope                = data.azurerm_resource_group.northstar.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.northstar_app.principal_id
}
