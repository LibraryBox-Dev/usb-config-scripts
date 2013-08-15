#!/bin/sh
#
#   AutoConfiguration via USB file
#
#      Set Port for Sync Access in librarybox configuration
#
# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST librarybox_ftpsyncport"

librarybox_ftpsyncport_myself="librarybox_ftpsyncport"       #contains the name of the module
librarybox_ftpsyncport_config_file="librarybox_ftpsyncport"

# FTP configuration is currently located in the hook
#librarybox_config=/opt/piratebox/conf/piratebox.conf
ftp_config=/opt/piratebox/conf/ftp/ftp.conf

# Read configuration out of the system and save it to librarybox_ftpsyncport_system_config depending on the 
#   parameter
func_read_system_config_librarybox_ftpsyncport() {
	local path=$1 ; shift

	echo "Extracting FTP-Sync port  from $ftp_config"
	config_line=$(grep SYNC_PORT=\" $ftp_config )
	#extract value
	config_line=${config_line#SYNC_PORT=\"}
	config_value=${config_line%\"}

	echo $config_value  >  $path/$librarybox_ftpsyncport_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_librarybox_ftpsyncport(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing ftp-sync Port for LibraryBox"
	sed "s|SYNC_PORT=\"$old_value\"|SYNC_PORT=\"$value\"|" -i $ftp_config

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_librarybox_ftpsyncport(){

        auto_config_lookup_and_set  "$librarybox_ftpsyncport_myself" \
                "$cfg_auto_folder/$librarybox_ftpsyncport_config_file" \
                "$cfg_tmp_folder/$librarybox_ftpsyncport_config_file"

}
