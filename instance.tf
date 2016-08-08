resource "openstack_compute_instance_v2" "basic" {
  name = "${var.openstack_instance_name}"
  image_id = "${var.openstack_instance_image_id}"
  flavor_id = "${var.openstack_instance_falvor_id}"
  network { uuid = "${openstack_networking_network_v2.net01.id}" } 
  floating_ip = "${openstack_compute_floatingip_v2.floatip_1.address}"
  key_pair = "${var.openstack_instance_key_pair}"
}

resource "openstack_compute_floatingip_v2" "floatip_1" {
  pool = "${var.openstack_floating_ip_pool}"
}
