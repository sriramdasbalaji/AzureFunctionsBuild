provider "azurerm" { }

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 4
}

resource "azurerm_resource_group" "test" {
  name     = "terraformlab"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "test" {
  name                = "terraform-app-service-plan"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "partsunlimitedwebapp-${random_id.server.hex}"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.test.id}"

}

