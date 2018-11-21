provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id = "${var.client_id}"
    tenant_id = "${var.tenant_id}"
}

provide "infoblox" {
    username =
    password =
    server = "http://"
}

terraform {
    backend "azurerm" {
        storage_account_name = "terrapoc"
        container_name = "terrablob"
        key = "<key name>"
    }
}