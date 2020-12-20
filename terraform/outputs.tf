output "master-ip" {
    description = "mater node ipv4 address"
    value = "${hcloud_server.web.ipv4_address}"
}
