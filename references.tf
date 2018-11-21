data "terraform_remote_state" "network" {
    backend = "azurerm"

    config {
        storage_account_name = "terrapoc"
        container_name = "terrablob"
        key = ""
    }
}

data "terraform_remote_state" "oms" {
    backend = "azurerm"

    config {
        storage_account_name = "terrapoc"
        container_name = "terrablob"
        key = ""
    }
}