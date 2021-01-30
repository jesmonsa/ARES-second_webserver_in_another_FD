resource "oci_core_internet_gateway" "ARESInternetGateway" {
    compartment_id = oci_identity_compartment.ARESCompartment.id
    display_name = "ARESInternetGateway"
    vcn_id = oci_core_virtual_network.ARESVCN.id
}
