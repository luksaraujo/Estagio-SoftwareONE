provider "azurerm" {
    version = "2.75.0"
    features {}
}

resource "azurerm_network_security_group" "LuksTestNSG" {
    name = "luksTestNSG"
    location = "brazilsouth"
    resource_group_name = var.resourceGroupName
}

resource "azurerm_network_security_rule" "Porta80" {
    name = "Allow80Port"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_network_security_group.LuksTestNSG.resource_group_name
    network_security_group_name = azurerm_network_security_group.LuksTestNSG.name
}

resource "azurerm_network_security_rule" "Porta443" {
    name = "Allow443Port"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_network_security_group.LuksTestNSG.resource_group_name
    network_security_group_name = azurerm_network_security_group.LuksTestNSG.name
}

resource "azurerm_virtual_network" "lukstest-vnet" {
    name = "lukstest-vnet"
    location = var.location
    resource_group_name = var.resourceGroupName
    address_space = ["10.0.0.0/16"]
    dns_servers = ["8.8.8.8", "8.8.4.4"]

    tags = {
        enviroment = "Dev"
    }
}

resource "azurerm_subnet" "lukstest-subNet" {
    name = "lukstest-azSubnet"
    resource_group_name = azurerm_network_security_group.LuksTestNSG.resource_group_name
    virtual_network_name = azurerm_virtual_network.lukstest-vnet.name
    address_prefix = "10.0.1.0/24"
}

resource "azurerm_public_ip" "lukstest-publicIP" {
    name = "lukstest-pubIp"
    location = "brazilsouth"
    resource_group_name = azurerm_network_security_group.LuksTestNSG.resource_group_name
    allocation_method = "Static"
    ip_version = "IPv4"

    tags = {
        enviroment = "Dev"
    }
}

