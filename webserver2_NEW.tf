resource "oci_core_instance" "ARESWebserver2" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")
  compartment_id = oci_identity_compartment.ARESCompartment.id
  display_name = "ARESWebServer2"
  shape = var.Shapes[0]
  subnet_id = oci_core_subnet.ARESWebSubnet.id
  fault_domain = "FAULT-DOMAIN-2"
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

data "oci_core_vnic_attachments" "ARESWebserver2_VNIC1_attach" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name")
  compartment_id = oci_identity_compartment.ARESCompartment.id
  instance_id = oci_core_instance.ARESWebserver2.id
}

data "oci_core_vnic" "ARESWebserver2_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.ARESWebserver2_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "ARESWebserver2PublicIP" {
value = [data.oci_core_vnic.ARESWebserver2_VNIC1.public_ip_address]
}
