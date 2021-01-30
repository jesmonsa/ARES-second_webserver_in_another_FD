resource "oci_identity_compartment" "ARESCompartment" {
  name = "ARESCompartment"
  description = "ARES Compartment"
  compartment_id = var.compartment_ocid
}

