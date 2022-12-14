# ----------------------------------------
# Get Azure Subscription
# ----------------------------------------
data "azurerm_subscription" "current" {
}

# ----------------------------------------
# Tags policy for resources, except resource group
# ----------------------------------------
resource "azurerm_policy_definition" "tags_on_resources" {
  name         = "Require a tags on resources"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require a tags on resources"
  description  = "Enforces existence of a tags"

  metadata    = jsonencode({ "category" : "Tags" })
  policy_rule = file("${path.module}/tags_on_resources_policy_rule.json")
  parameters  = file("${path.module}/tags_policy_parameters.json")
}

resource "azurerm_subscription_policy_assignment" "resources" {
  name                 = "Require a tags on resources"
  policy_definition_id = azurerm_policy_definition.tags_on_resources.id
  subscription_id      = data.azurerm_subscription.current.id

  enforce     = true
  description = "Resources must have the following tags: Owner, Project, Environment, Management"

  non_compliance_message {
    content = "Resources must have the following tags: Owner, Project, Environment, Management"
  }
}

# ----------------------------------------
# Tags policy for resource group
# ----------------------------------------
resource "azurerm_policy_definition" "tags_on_resource_group" {
  name         = "Require a tags on resource group"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Require a tags on resource group"
  description  = "Enforces existence of a tags"

  metadata    = jsonencode({ "category" : "Tags" })
  policy_rule = file("${path.module}/tags_on_resource_group_policy_rule.json")
  parameters  = file("${path.module}/tags_policy_parameters.json")
}

resource "azurerm_subscription_policy_assignment" "resource_group" {
  name                 = "Require a tags on resource group"
  policy_definition_id = azurerm_policy_definition.tags_on_resource_group.id
  subscription_id      = data.azurerm_subscription.current.id

  enforce     = true
  description = "Resource group must have the following tags: Owner, Project, Environment, Management"

  non_compliance_message {
    content = "Resource group must have the following tags: Owner, Project, Environment, Management"
  }
}


