provider "azurerm" {
    version = "2.5.0"
    features {}
} 

 terraform {
  backend "azurerm" {
    resource_group_name = "tfmainrg"
    storage_account_name = "terraformstoreg"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
  
}


resource "azurerm_resource_group" "tf_test"{
    name = "tfmainrg"
    location = "West Europe"
}

resource "azurerm_container_group" "tfcg_test"{
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name
    
    ip_address_type   = "public"
    dns_name_label    = "zeljo988wewapi"
    os_type           = "Linux"

    container  {
        name  = "weatherapi"
        image = "zeljo988/weatherapi"
        cpu   = "1"
        memory =   "1"
        ports {
            port = 80
            protocol = "TCP"
        }
    }
}