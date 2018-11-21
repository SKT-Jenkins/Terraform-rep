output "linux_server_ip" {
    value = "${module.stripathi_linux_servers.private_ip}"
}

output "linux_server_fqdn" {
    value = "${module.stripathi_linux_servers.fqdn}"
}

output "linux_server_hostname" {
    value = "${module.stripathi_linux_servers.hostname}"
}

output "windows_server_ip" {
    value = "${module.stripathi_linux_servers.private_ip}"
}

output "windows_server_fqdn" {
    value = "${module.stripathi_linux_servers.fqdn}"
}

output "windows_server_hostname" {
    value = "${module.stripathi_linux_servers.hostname}"
}