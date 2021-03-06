data "ibm_resource_group" "rg" {
  name = var.resource_group
}
resource "ibm_is_vpc" "test_tg_vpc" {
  name = "myvpc"
}
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
}

resource "ibm_tg_gateway" "new_tg_gw"{
name="tg-gateway-1"
location="us-south"
global=true
resource_group = data.ibm_resource_group.rg.id
} 

data "ibm_tg_gateway" "tg_gateway" {
name="tg-gateway-1"
}

data "ibm_tg_gateways" "all_tg_gws"{

}

data "ibm_tg_locations" "tg_locations" {
}

data "ibm_tg_location" "tg_location" {
	name = "us-south"
} 
 
resource "ibm_tg_connection" "test_ibm_tg_connection"{
		gateway = "${ibm_tg_gateway.new_tg_gw.id}"
		network_type = "vpc"
		name= "myconnection"
		network_id = ibm_is_vpc.test_tg_vpc.resource_crn
}
// cross account
resource "ibm_tg_connection" "test_ibm_tg_connection"{
		gateway = "${ibm_tg_gateway.new_tg_gw.id}"
		network_type = "vpc"
		name= "mycrossconnection"
		// vpc crn from other account
		network_id = var.network_id
		network_account_id = var.network_account_id
}