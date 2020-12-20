output "master-ip" {
    description = "mater node ipv4 address"
    value = "${hcloud_server.web.ipv4_address}"
}


output "floating-ip" {
    description = "floating ip ipv4 address"
    value = "${hcloud_floating_ip.floating-ip.ip_address}"
}
