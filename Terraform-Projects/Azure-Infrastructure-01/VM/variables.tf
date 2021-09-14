variable "subscriptionID" {
    type = string
    description = "ID da subscription"
}

variable "resourceGroupName" {
    type = string
    description = "Nome do resource group"
}

variable "location" {
    type = string
    description = "Location do Resource group"
}

variable "network_interface_ID" {
    type = string
}

variable "tags" {
    type = object({
        enviroment = string
    })
    description = "Tags utilizadas na maioria dos resources"
}