resource "oci_core_virtual_network" "ARESVCN" {
  cidr_block = var.VCN-CIDR
  dns_label = "ARESVCN"
  compartment_id = oci_identity_compartment.ARESCompartment.id
  display_name = "ARESVCN"
}

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

# Gets the Id of a specific OS Images
data "oci_core_images" "OSImageLocal" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = var.OsImage
}
