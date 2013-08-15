#!/bin/sh
#
#   AutoConfiguration via USB file
#
#      Enable, Disable sync access for librarybox configuration
#
# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST librarybox_ftpsync"

librarybox_ftpsync_myself="librarybox_ftpsync"       #contains the name of the module
librarybox_ftpsync_config_file="librarybox_ftpsync"

# FTP configuration is currently located in the hook
#librarybox_config=/opt/piratebox/conf/piratebox.conf
ftp_config=/opt/piratebox/conf/ftp/ftp.conf

# Read configuration out of the system and save it to librarybox_ftpsync_system_config depending on the 
#   parameter
func_read_system_config_librarybox_ftpsync() {
	local path=$1 ; shift

	echo "Extracting FTP-Sync parameter from $ftp_config"
	config_line=$(grep ENABLE_SYNC=\" $ftp_config )
	#extract value
	config_line=${config_line#ENABLE_SYNC=\"}
	config_value=${config_line%\"}

	echo $config_value  >  $path/$librarybox_ftpsync_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_librarybox_ftpsync(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing ftp-sync access for LibraryBox"
	sed "s|ENABLE_SYNC=\"$old_value\"|ENABLE_SYNC=\"$value\"|" -i $ftp_config

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_librarybox_ftpsync(){

        auto_config_lookup_and_set  "$librarybox_ftpsync_myself" \
                "$cfg_auto_folder/$librarybox_ftpsync_config_file" \
                "$cfg_tmp_folder/$librarybox_ftpsync_config_file"

}
