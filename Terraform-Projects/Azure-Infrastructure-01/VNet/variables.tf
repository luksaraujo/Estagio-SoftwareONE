variable "subscriptionID" {
    type = string
    description = "ID da Subscription do Azure"
}

variable "resourceGroupName" {
    type = string
    description = "Nome do Resource Group"
}

variable "location" {
    type = string
    description = "Location do Resource Group"
}

variable "tags" {
    type = object({
        enviroment = string
    })
    description = "Tags utilizadas na maioria dos resources"
}