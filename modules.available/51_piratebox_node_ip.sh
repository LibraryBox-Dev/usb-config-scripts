#!/bin/sh
#
#   AutoConfiguration via USB file
#
#      Prints out the PirateBox Node IP and changes it
#        DOES NOT change  IP in OPENWRT network config
#
# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST piratebox_node_ip"

piratebox_node_ip_myself="piratebox_node_ip"       #contains the name of the module
piratebox_node_ip_config_file="piratebox_node_ip.txt"

node_config=/opt/piratebox/conf/node.conf

# Read configuration out of the system and save it to piratebox_node_ip_system_config depending on the 
#   parameter
func_read_system_config_piratebox_node_ip() {
	local path=$1 ; shift

	echo "Extracting Node-IPv6 IP parameter from $node_config"
	config_line=$(grep NODE_IPV6_IP=\' $node_config )
	#extract value
	config_line=${config_line#NODE_IPV6_IP=\'}
	config_value=${config_line%\'}

	echo $config_value  >  $path/$piratebox_node_ip_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_piratebox_node_ip(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing PirateBox node ipv6 ip ..."
	sed "s|NODE_IPV6_IP='$old_value'|NODE_IPV6_IP='$value'|" -i $node_config

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_piratebox_node_ip(){

        auto_config_lookup_and_set  "$piratebox_node_ip_myself" \
                "$cfg_auto_folder/$piratebox_node_ip_config_file" \
                "$cfg_tmp_folder/$piratebox_node_ip_config_file"

}
