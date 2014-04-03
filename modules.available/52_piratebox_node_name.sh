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
MODULE_LIST="$MODULE_LIST piratebox_node_name"

piratebox_node_name_myself="piratebox_node_name"       #contains the name of the module
piratebox_node_name_config_file="piratebox_node_name.txt"

node_config=/opt/piratebox/conf/node.conf

# Read configuration out of the system and save it to piratebox_node_name_system_config depending on the 
#   parameter
func_read_system_config_piratebox_node_name() {
	local path=$1 ; shift

	echo "Extracting Node-NAME parameter from $node_config"
	config_line=$(grep NODE_NAME=\" $node_config )
	#extract value
	config_line=${config_line#NODE_NAME=\'}
	config_value=${config_line%\'}

	echo $config_value  >  $path/$piratebox_node_name_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_piratebox_node_name(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing PirateBox node node name ..."
	sed "s|NODE_NAME='$old_value'|NODE_NAME='$value'|" -i $node_config

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_piratebox_node_name(){

        auto_config_lookup_and_set  "$piratebox_node_name_myself" \
                "$cfg_auto_folder/$piratebox_node_name_config_file" \
                "$cfg_tmp_folder/$piratebox_node_name_config_file"

}
