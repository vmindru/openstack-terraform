# bellow can be repalced with image_name , this would lookup the desired image_id and is more dynamic solution
# bellow can be replaced wiht flavor_name ,  this would lookup the desired flavor_id and is more dynamic solution

resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.openstack_user_name}-ansible-keypair"
  public_key = "${var.openstack_instance_key_pair}"
}


resource "openstack_compute_instance_v2" "test-vm" {
  count = "${var.openstack_instance_count}"
  name = "${format("${var.openstack_instance_name}-%02d",count.index+1)}"
  image_id = "${var.openstack_instance_image_id}"
  flavor_id = "${var.openstack_instance_flavor_id}"
  network { uuid = "${openstack_networking_network_v2.net01.id}" } 
  floating_ip = "${element(openstack_compute_floatingip_v2.test-vm.*.address, count.index)}"
  key_pair = "${openstack_compute_keypair_v2.keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.secgroup01.name}"]
  depends_on = ["openstack_networking_router_v2.rt01","openstack_networking_router_interface_v2.rt01-interface-01"]

  
  provisioner "local-exec" {
        command = "grep ${element(openstack_compute_floatingip_v2.test-vm.*.address, count.index)}   ~/.ssh/known_hosts"
  }

  provisioner "remote-exec" {
        inline = [
        "mkdir ~/.ssh",
        "chmod 600 ~/.ssh",
        "echo ${var.openstack_instance_key_pair} >> ~/.ssh/authorized_keys ",,
        "chmod 600 ~/.ssh/authorized_keys"
        ]
    
        connection {
            user = "root"
            password = "${var.root_password}"
        }
  }

  provisioner "local-exec" {
      command = "ansible-playbook --private-key ${var.ansible_private_key} -i '${element(openstack_compute_floatingip_v2.test-vm.*.address, count.index)},'  -s ${var.ansible_plyabook_path} -T 300 -u root"
  }



}

resource "openstack_compute_floatingip_v2" "test-vm" {
  count = "${var.openstack_instance_count}"
  pool = "${var.openstack_floating_ip_pool}"
  depends_on = ["openstack_networking_router_v2.rt01","openstack_networking_router_interface_v2.rt01-interface-01"]

}


