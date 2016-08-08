resource "openstack_compute_instance_v2" "basic" {
  name = "basic"
  image_id = "2665a046-b754-4e02-af93-f63178276b91"
  flavor_id = "3"
  network { uuid = "${openstack_networking_network_v2.net01.id}" } 
  admin_pass = "test"
  floating_ip = "${openstack_compute_floatingip_v2.floatip_1.address}"
}

resource "openstack_compute_floatingip_v2" "floatip_1" {
  pool = "10.8.180.0/22"
}
