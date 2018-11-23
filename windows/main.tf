data "azurerm_subscription" "current" {}

module "refdata" {
    source = "../../refdata"
}

locals {
    os_type = "W"
    hostname_prefix = "${lookup(module.refdata.platform_section_by_env, var.environment)}"
    prefix =
    dns_zone =
    chef_server_url =
    chef_validation_key_url =
    static_ip_count =
    dynamic_ip_count =

    common_tags = {
        troux_id = "${var.troux_id}"
        resource_owner =
        cost_center =
        expiry_data =
        os =
    }
}

resource "random_string" "hostname_suffix" {
    count =
    length =
    lower = false
    number = true
    special = falseupper = true

    keepers = {
        name = "${var.resource_group}"
    }

}

resource "azurerm_network_interface" "winni" {
    count =
    name =
    location =
    resource_group_name =

    ip_configuration {
        name =
        subnet_id =
        private_ip_address_allocation = "${local.dynamic_ip_count >= 1 ? "dynamic" : "static"}"
        private_ip_address = "${local.dynamic_ip_count >= 1? "" : element(concat(var.static_ips, list("")), count.index)}"
    }

    lifecycle {
        ignore_changes = ["name", "ip_configuration"]
    }

    tags = "${merge(var.extra_tags, local.common_tags)}"
}

resource "infoblox_arecord" "winvm_name" {
    count = "{var.count}"
    ipv4addr = "${azurerm_network_interface.winni.*.private_ip_address[count.index]}"
    name = "$lower("${azurerm_virtual_machine.winvm.*.name[count.index]}.${local.dns_zone}")}"
    ttl = "3600"

    lifecycle {
        ignore_changes = ["name"]
    }

}

resource "azurerm_virtual_machine" "winvm" {
    count =
    name =
    location =
    resource_group_name =
    network_interface_ids = ["${azurerm_network_interface.winni.*.id[count.index]}"]
    vm_size = "${contains(keys(module.refdata.vm_size_mp), var.size) ? lookup(module.refdata.vm_size_map, var.size, "") : var.size}"
    delete_os_disk_on_termination = true
    license_type = 

    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2016-Datacenter"
        version = "latest"
    }

    storage_os_disk {
        name =
        managed_disk_type =
        disk_size_gb =
        caching = 
        create_option =
    }

    os_profile {
        computer_name = 
        admin_username = 
        admin_password = 
        custom_data = "${var.provision ? format("%s",data.template_file.chef.rendered) : ""}"
    }

    os_profile_windows_config {
        provision_vm_agent = true
    }

    lifecycle {
        ignore_changes = ["storage_os_disk", "storage_image_referece", "os_profile", "name"]
    }

    identity {
        type = "SystemAssigned"
    }

    tags = "${merge(var.extra_tags, local.common_tags)}"
}

data "template_file" "chef" {
    template = "${file("${path.module}/templates/chef.ps1")}"

    vars {
       chef_server_url =
       chef_validation_key_url =
       chef_validation_client_name = 
       chef_server_run_list =
       chef_environment = 
    }
}

resource "azurerm_virtual_machine_extension" "bootstrap" {
    count =
    name =
    location =
    resource_group_name =
    virtual_machine_name =
    publisher =
    type =
    type_handler_version = 

    settings = <<SETTINGS
      {
          "commandToExecute": "copy c:\\azuredata\\customdata.bin c:\\azuredata\\customdata.ps1 && powershell - ExecutionPolicy Unrestricted -File c:\\azuredata\\customdata.ps1"
      }
      SETTINGS

      tags = "${merge(var.extra_tags, local.common_tags)}"
}