# ----------------------------------------------
# Get Azure Subscription
# ----------------------------------------------
data "azurerm_subscription" "current" {
}

# ----------------------------------------------
# Tags policy
# ----------------------------------------------
module "tags_policy" {
  source = "./modules/policy"
}

# ----------------------------------------------
# Service Principal with Client Secret for authenticating to Terraform Cloud
# ----------------------------------------------
module "terraform_cloud_service_principal" {
  source  = "app.terraform.io/sivonte/service-principal/azure" // Private module
  version = "1.0.2"

  owner       = var.owner
  project     = var.project
  environment = var.environment
  management  = var.management

  application_display_name      = "sp-terraform-cloud-sivonte"
  service_principal_description = "The Application (service principal) for authenticating sivonte organization to Terraform Cloud."
  password_rotation_in_days = 1

  assignments = [
    {
      scope                = data.azurerm_subscription.current.id
      role_definition_name = "Contributor"
    }
  ]
}
