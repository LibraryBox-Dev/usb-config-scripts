#!/bin/sh
#
#   AutoConfiguration via USB file
##
#  Set channel on OpenWRT
#


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST openwrt_channel"

openwrt_channel_myself="openwrt_channel"       #contains the name of the module
openwrt_channel_config_file="channel.txt"

interface_no=0

# Read configuration out of the system and save it to openwrt_channel_system_config depending on the 
#   parameter
func_read_system_config_openwrt_channel() {
	local path=$1 ; shift

	 echo "Getting channel of device-$interface_no via uci"
	 uci get "wireless.@wifi-device[$interface_no].channel" >  $path/$openwrt_channel_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_openwrt_channel(){
	local value=$1 ; shift
	uci set "wireless.radio0.channel=$value"
}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_openwrt_channel(){


	 auto_config_lookup_and_set  "$openwrt_channel_myself" \
		"$cfg_auto_folder/$openwrt_channel_config_file" \
		"$cfg_tmp_folder/$openwrt_channel_config_file"


}
