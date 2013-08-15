#!/bin/sh
#
#   AutoConfiguration via USB file
#
#      Enable, Disable ftp for librarybox configuration
#
# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST librarybox_ftp"

librarybox_ftp_myself="librarybox_ftp"       #contains the name of the module
librarybox_ftp_config_file="librarybox_ftp.txt"

# FTP configuration is currently located in the hook
#librarybox_config=/opt/piratebox/conf/piratebox.conf
piratebox_config=/opt/piratebox/conf/hook_custom.conf

# Read configuration out of the system and save it to librarybox_ftp_system_config depending on the 
#   parameter
func_read_system_config_librarybox_ftp() {
	local path=$1 ; shift

	echo "Extracting FTP parameter from $piratebox_config"
	config_line=$(grep FTP_ENABLED=\" $piratebox_config )
	#extract value
	config_line=${config_line#FTP_ENABLED=\"}
	config_value=${config_line%\"}

	echo $config_value  >  $path/$librarybox_ftp_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_librarybox_ftp(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing ftp for LibraryBox"
	sed "s|FTP_ENABLED=\"$old_value\"|FTP_ENABLED=\"$value\"|" -i $piratebox_config

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_librarybox_ftp(){

        auto_config_lookup_and_set  "$librarybox_ftp_myself" \
                "$cfg_auto_folder/$librarybox_ftp_config_file" \
                "$cfg_tmp_folder/$librarybox_ftp_config_file"

}
