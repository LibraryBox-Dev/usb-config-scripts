#!/bin/sh
#
#   AutoConfiguration via USB file
#
#      Changes hostname for piratebox configuration
#
# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST piratebox_hostname"

piratebox_hostname_myself="piratebox_hostname"       #contains the name of the module
piratebox_hostname_config_file="hostname"

piratebox_config=/opt/piratebox/conf/piratebox.conf
piratebox_install_sh=/opt/piratebox/bin/install_piratebox.sh

# Read configuration out of the system and save it to piratebox_hostname_system_config depending on the 
#   parameter
func_read_system_config_piratebox_hostname() {
	local path=$1 ; shift

	echo "Extracting HOST parameter from piratebox.conf"
	config_line=$(grep HOST=\" $piratebox_config )
	#extract value
	config_line=${config_line#HOST=\"}
	config_value=${config_line%\"}

	echo $config_value  >  $path/$piratebox_hostname_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_piratebox_hostname(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing hostname for PirateBox with install_piratebox.sh"
	$piratebox_install_sh "$piratebox_config" hostname "$1"
}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_piratebox_hostname(){

        auto_config_lookup_and_set  "$piratebox_hostname_myself" \
                "$cfg_auto_folder/$piratebox_hostename_config_file" \
                "$cfg_tmp_folder/$piratebox_hostename_config_file"

}
