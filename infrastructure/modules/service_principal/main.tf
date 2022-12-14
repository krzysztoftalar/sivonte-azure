# Get the configuration of the AzureAD provider
data "azuread_client_config" "current" {}

# Application
resource "azuread_application" "this" {
  display_name     = var.application_display_name
  sign_in_audience = var.sign_in_audience
  owners           = [data.azuread_client_config.current.object_id]

  tags = local.tags
}

# Service Principal
resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
  owners         = [data.azuread_client_config.current.object_id]

  description = var.service_principal_description
  notes       = var.service_principal_description

  tags = local.tags
}

# Role assignments (Subscription) for service principal
resource "azurerm_role_assignment" "this" {
  count = length(var.assignments)

  principal_id         = azuread_service_principal.this.object_id
  scope                = var.assignments[count.index].scope
  role_definition_name = var.assignments[count.index].role_definition_name

  description = "description"
}

# Manages a rotating time resource
resource "time_rotating" "this" {
  rotation_rfc3339 = var.password_end_date
  rotation_years   = var.password_rotation_in_years
  rotation_days    = var.password_rotation_in_days

  triggers = {
    end_date = var.password_end_date
    years    = var.password_rotation_in_years
    days     = var.password_rotation_in_days
  }
}

# Application Client Secret
resource "azuread_application_password" "this" {
  display_name = var.application_display_name
  application_object_id = azuread_application.this.object_id

  rotate_when_changed = {
    rotation = time_rotating.this.id
  }
}
