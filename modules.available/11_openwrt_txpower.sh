#!/bin/sh
#
#   AutoConfiguration via USB file
##
#  Set txpower on OpenWRT
#


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST openwrt_txpower"

openwrt_txpower_myself="openwrt_txpower"       #contains the name of the module
openwrt_txpower_config_file="txpower.txt"

interface_no=0

# Read configuration out of the system and save it to openwrt_txpower_system_config depending on the 
#   parameter
func_read_system_config_openwrt_txpower() {
	local path=$1 ; shift

	 echo "Getting txpower of device-$interface_no via uci"
	 uci get "wireless.@wifi-device[$interface_no].txpower" >  $path/$openwrt_txpower_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_openwrt_txpower(){
	local value=$1 ; shift
	uci set "wireless.radio0.txpower=$value"
	uci_commit_needed="1"
}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_openwrt_txpower(){


	 auto_config_lookup_and_set  "$openwrt_txpower_myself" \
		"$cfg_auto_folder/$openwrt_txpower_config_file" \
		"$cfg_tmp_folder/$openwrt_txpower_config_file"


}
