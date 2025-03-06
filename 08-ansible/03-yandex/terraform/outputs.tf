output "info-vms" {
    value = concat(
        [for instance in yandex_compute_instance.vm : {
            name    = instance.name,
            id      = instance.id,
            internal_ip = instance.network_interface.0.ip_address,
            ip      = instance.network_interface.0.nat_ip_address,
            fqdn    = instance.fqdn
        }]
    )
}