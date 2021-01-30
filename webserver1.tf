resource "oci_core_instance" "ARESWebserver1" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")
  compartment_id = oci_identity_compartment.ARESCompartment.id
  display_name = "ARESWebServer1"
  shape = var.Shapes[0]
  subnet_id = oci_core_subnet.ARESWebSubnet.id
  fault_domain = "FAULT-DOMAIN-1"
  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.OSImageLocal.images[0], "id")
  }
  metadata = {
      ssh_authorized_keys = file(var.public_key_oci)
  }
  create_vnic_details {
     subnet_id = oci_core_subnet.ARESWebSubnet.id
     assign_public_ip = true 
  }
}

data "oci_core_vnic_attachments" "ARESWebserver1_VNIC1_attach" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")
  compartment_id = oci_identity_compartment.ARESCompartment.id
  instance_id = oci_core_instance.ARESWebserver1.id
}

data "oci_core_vnic" "ARESWebserver1_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.ARESWebserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "ARESWebserver1PublicIP" {
   value = [data.oci_core_vnic.ARESWebserver1_VNIC1.public_ip_address]
}
