resource "oci_core_subnet" "ARESWebSubnet" {
  cidr_block = "10.0.1.0/24"
  display_name = "ARESWebSubnet"
  dns_label = "ARESN1"
  compartment_id = oci_identity_compartment.ARESCompartment.id
  vcn_id = oci_core_virtual_network.ARESVCN.id
  route_table_id = oci_core_route_table.ARESRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.ARESDhcpOptions1.id
  security_list_ids = [oci_core_security_list.ARESSecurityList.id]
}


