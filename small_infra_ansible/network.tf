resource "openstack_networking_network_v2" "net01" {
  name = "${var.openstack_tenant_name}-net01"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet01" {
  name = "${var.openstack_tenant_name}-subnet01"
  network_id = "${openstack_networking_network_v2.net01.id}"
  cidr = "${var.openstack_subnet_cidr}"
  ip_version = 4
}

resource "openstack_compute_secgroup_v2" "secgroup01" {
  name = "${var.openstack_tenant_name}-secgroup01"
  description = "default security group, allow SSH and ICMP from everywhere"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
 rule {
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0" 
    from_port = "-1"
    to_port = "-1"
 }
}


