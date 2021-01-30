resource "oci_core_dhcp_options" "ARESDhcpOptions1" {
  compartment_id = oci_identity_compartment.ARESCompartment.id
  vcn_id = oci_core_virtual_network.ARESVCN.id
  display_name = "ARESDHCPOptions1"

  // required
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type = "SearchDomain"
    search_domain_names = [ "ARES.com" ]
  }
}
