# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl
resource "oci_core_security_list" "control_plane_seclist" {
  compartment_id = var.compartment_id
  display_name   = local.cp_seclist_name
  vcn_id         = var.vcn_id

  dynamic "egress_security_rules" {
    iterator = cp_egress_iterator
    for_each = local.cp_egress_seclist

    content {
      description      = cp_egress_iterator.value["description"]
      destination      = cp_egress_iterator.value["destination"]
      destination_type = cp_egress_iterator.value["destination_type"]
      protocol         = cp_egress_iterator.value["protocol"]
      stateless        = cp_egress_iterator.value["stateless"]

      dynamic "tcp_options" {
        for_each = cp_egress_iterator.value["protocol"] == local.tcp_protocol && cp_egress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = cp_egress_iterator.value["port"]
          max = cp_egress_iterator.value["port"]
        }
      }
    }
  }

  dynamic "ingress_security_rules" {
    iterator = cp_ingress_iterator
    for_each = local.cp_ingress_seclist

    content {
      description      = cp_ingress_iterator.value["description"]
      source           = cp_ingress_iterator.value["source"]
      source_type      = cp_ingress_iterator.value["source_type"]
      protocol         = cp_ingress_iterator.value["protocol"]
      stateless        = cp_ingress_iterator.value["stateless"]

      dynamic "tcp_options" {
        for_each = cp_ingress_iterator.value["protocol"] == local.tcp_protocol && cp_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = cp_ingress_iterator.value["port"]
          max = cp_ingress_iterator.value["port"]
        }
      }
    }
  }
  
  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
}


resource "oci_core_security_list" "worker_seclist" {
  compartment_id = var.compartment_id
  display_name   = local.worker_seclist_name
  vcn_id         = var.vcn_id

  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
}


resource "oci_core_security_list" "int_lb_seclist" {
  compartment_id = var.compartment_id
  display_name   = local.intlb_seclist_name
  vcn_id         = var.vcn_id

  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
}

resource "oci_core_security_list" "pub_lb_seclist" {
  compartment_id = var.compartment_id
  display_name   = local.publb_seclist_name
  vcn_id         = var.vcn_id

  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
}