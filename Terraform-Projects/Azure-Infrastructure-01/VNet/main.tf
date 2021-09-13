provider "azurerm" {
    version = "2.75.0"
    features {}
}

resource "azurerm_resource_group" "rg" {
    name = var.resourceGroupName
    location = var.location
    tags = var.tags
}

resource "azurerm_network_security_group" "nsg" {
    name = "TerraformTest01-NSG"
    location = azurerm_virtual_network.vnet.location
    resource_group_name = azurerm_resource_group.rg.name
    tags = var.tags
    depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_virtual_network" "vnet" {
    name = "TerraformTest01-VNet"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["10.0.0.0/16"]
    dns_servers = ["8.8.8.8", "8.8.4.4"]
    tags = var.tags
    depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_subnet" "subnet" {
    name = "TerraformTest01-Subnet"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]
    depends_on = [azurerm_virtual_network.vnet]
    tags = var.tags
}

resource "azurerm_network_interface" "nic" {
    name = "TerraformTest01-NIC"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    depends_on = [azurerm_subnet.subnet]
}