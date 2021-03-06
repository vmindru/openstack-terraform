resource "openstack_networking_router_v2" "rt01" {
  name = "${var.openstack_tenant_name}-rt01"
  external_gateway = "${var.openstack_gateway_network_id}"
}

resource "openstack_networking_router_interface_v2" "rt01-interface-01" {
  router_id = "${openstack_networking_router_v2.rt01.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet01.id}"
}
