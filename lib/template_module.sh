#!/bin/sh
#
#   AutoConfiguration via USB file
#     This is a template module, which contains empty functions, which can be called
#
#     name shema is 
#	nn_name.sh
#
#	functions are named with 
#		name_fffff
#	where ffff is the predifined template step.

# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
#MODULE_LIST="$MODULE_LIST template"

template_myself="template"       #contains the name of the module
template_config_file="template"

# Read configuration out of the system and save it to template_system_config depending on the 
#   parameter
func_read_system_config_template() {
	local path=$1 ; shift
	echo "" >  $path/$template_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_template(){
	local value=$1 ; shift
	local old_value=$1 ; shift
}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_template(){

        auto_config_lookup_and_set  "$openwrt_ssid_myself" \
                "$cfg_auto_folder/$openwrt_ssid_config_file" \
                "$cfg_tmp_folder/$openwrt_ssid_config_file"

}
