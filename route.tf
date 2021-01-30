resource "oci_core_route_table" "ARESRouteTableViaIGW" {
    compartment_id = oci_identity_compartment.ARESCompartment.id
    vcn_id = oci_core_virtual_network.ARESVCN.id
    display_name = "ARESRouteTableViaIGW"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_internet_gateway.ARESInternetGateway.id
    }
}
