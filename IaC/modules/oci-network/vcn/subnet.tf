# tf script to create oci vcn subnet_cidr_block

resource "oci_core_subnet" "test_subnet" {
    #Required
    cidr_block = var.subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    display_name = var.subnet_name
    security_list_ids = [oci_core_security_list.test_security_list.id]
}


resource "oci_core_security_list" "test_security_list" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.test_vcn.id

    display_name = "apigtw_sl"
    egress_security_rules {
        #Required
        destination = "0.0.0.0/0"
        protocol = "all"

        #Optional
        description = "api gtw security list - egress rule"
        destination_type = "CIDR_BLOCK"
        stateless = true                
    }
    freeform_tags = {"env"= "Dev"}
    ingress_security_rules {
        #Required
        protocol = "6" # TCP = "6"
        source = "10.0.0.0/16"
        #Optional
        description = "security list - ingress rule for port 80"
        source_type = "CIDR_BLOCK"
        stateless = true
        tcp_options {
            #Optional
            max = "80"
            min = "80"
        }
    }
}
