terraform {
  # Terraform Cloud setup
  cloud {
    organization = "sivonte"

    workspaces {
      name = "sivonte-azure"
    }
  }

  # Terraform version
  required_version = ">= 1.3.5"

  # Azure Provider source and version being used
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.35.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.31.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}

# Configure the Microsoft Azure Providers
provider "azurerm" {
  features {}
}

provider "azuread" {}
