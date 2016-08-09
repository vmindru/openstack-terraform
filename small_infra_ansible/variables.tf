# set following vars as shell ENV_VARS
#TF_VAR_openstack_user_name 
#TF_VAR_openstack_tenant_name  
#TF_VAR_openstack_password 
#TF_VAR_openstack_auth_url

variable "openstack_user_name" {}
variable "openstack_tenant_name" {}
variable "openstack_password" {}
variable "openstack_auth_url" {}


# NETWORK VARS 
variable "openstack_subnet_cidr" {
    description = "Subnet Cidr"
    default = "172.17.100.0/24"
}

variable "openstack_gateway_network_id" {
    description = "The UUID of the floating network, this will be used to  add gateway to the router"
}

variable "openstack_floating_ip_pool" {
    type = "string"
    description = "floating IP pool name, must be seted same as openstack_floating_ip_subnet_id"
}


# INSTANCE DETAILS 

variable "openstack_instance_count" {
    description = "how many instances do you want to create?"
}

variable "openstack_instance_name" {
    description = "instance name , or instance name prefix in case we will be spawning multiple instances"
}

variable "openstack_instance_image_id" {
    description = "image to boot the instance off, default RHEL-7.2-Server-x86_64-latest, obtain by  running openstack image list or nova image-list"
}

variable "openstack_instance_flavor_id" {
    description = "flavor of instance we want to start, get with openstack flavor list"
}

variable "openstack_instance_key_pair" {
    description = "keypair you want to use for this instance"
}

# FLOATING IP's

# ANSIBLE VARS 
variable "ansible_plyabook_path" { 
    description = "path to the playbook you want to run"
}

variable "root_password" {
    description = "root password, used to login to fresh created VM's"
}

variable "ansible_private_key" {
    description = "full path to your SSH private key, used to connect to the host"
}


