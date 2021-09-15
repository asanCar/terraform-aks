### -> Forces recreation

# Set Azure provider
terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = "= 2.68.0"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Create Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name ###
  location = var.location_extended ###

  tags = var.tags
}