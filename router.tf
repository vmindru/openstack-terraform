resource "openstack_networking_router_v2" "rt01" {
  external_gateway = "03670b37-8304-4518-9cfa-9ff17d197e12"
}

resource "openstack_networking_router_interface_v2" "rt01-interface-01" {
  router_id = "${openstack_networking_router_v2.rt01.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet01.id}"
}
