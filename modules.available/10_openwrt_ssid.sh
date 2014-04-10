#!/bin/sh
#
#   AutoConfiguration via USB file
##
#  Set SSID on OpenWRT
#


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST openwrt_ssid"

openwrt_ssid_myself="openwrt_ssid"       #contains the name of the module
openwrt_ssid_config_file="ssid.txt"

interface_no=0

# Read configuration out of the system and save it to openwrt_ssid_system_config depending on the 
#   parameter
func_read_system_config_openwrt_ssid() {
	local path=$1 ; shift

	 echo "Getting SSID of iface-$interface_no via uci"
	 uci get "wireless.@wifi-iface[$interface_no].ssid" >  $path/$openwrt_ssid_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_openwrt_ssid(){
	local value=$1 ; shift
	#Wifi-SSID can only be a maximum of 32 chars
	local cleaned=`echo $1 | cut -b 1-32 | head -n 1 `
	uci set "wireless.@wifi-iface[$interface_no].ssid=$value"
	uci_commit_needed="1"
}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_openwrt_ssid(){


	 auto_config_lookup_and_set  "$openwrt_ssid_myself" \
		"$cfg_auto_folder/$openwrt_ssid_config_file" \
		"$cfg_tmp_folder/$openwrt_ssid_config_file"


}
