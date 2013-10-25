#!/bin/sh
#
#   AutoConfiguration via USB file
##
#  Set hostname on OpenWRT
#


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST openwrt_hostname"

openwrt_hostname_myself="openwrt_hostname"       #contains the name of the module
openwrt_hostname_config_file="system_hostname.txt"

# Read configuration out of the system and save it to openwrt_hostname_system_config depending on the 
#   parameter
func_read_system_config_openwrt_hostname() {
	local path=$1 ; shift

	 echo "Getting system-hostname via uci"
	 uci get "system.@system[0].hostname" >  $path/$openwrt_hostname_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_openwrt_hostname(){
	local value=$1 ; shift

	ip=$(uci get network.lan.ipaddr)

	uci set "system.@system[0].hostname=$value"
	uci_commit_needed="1"

	echo "127.0.0.1 $value localhost." >/etc/hosts
	echo "$ip $value" >>/etc/hosts

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_openwrt_hostname(){


	 auto_config_lookup_and_set  "$openwrt_hostname_myself" \
		"$cfg_auto_folder/$openwrt_hostname_config_file" \
		"$cfg_tmp_folder/$openwrt_hostname_config_file"


}
