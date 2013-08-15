#!/bin/sh
#
#   AutoConfiguration via USB file
#
#      Enable, Disable ftpadmin for librarybox configuration
#
# Available global variables
#     CONFIG_TMP_STORE
#     CONFIG_STORE


#uncommend the following line for REAL modules
MODULE_LIST="$MODULE_LIST librarybox_ftpadmin"

librarybox_ftpadmin_myself="librarybox_ftpadmin"       #contains the name of the module
librarybox_ftpadmin_config_file="librarybox_ftpadmin"

# FTP configuration is currently located in the hook
#librarybox_config=/opt/piratebox/conf/piratebox.conf
ftp_config=/opt/piratebox/conf/ftp/ftp.conf

# Read configuration out of the system and save it to librarybox_ftpadmin_system_config depending on the 
#   parameter
func_read_system_config_librarybox_ftpadmin() {
	local path=$1 ; shift

	echo "Extracting FTP-admin parameter from $ftp_config"
	config_line=$(grep ADMIN_ACCESS=\" $ftp_config )
	#extract value
	config_line=${config_line#ADMIN_ACCESS=\"}
	config_value=${config_line%\"}

	echo $config_value  >  $path/$librarybox_ftpadmin_config_file
}

# Parse the first parameter with the changed value
#  do the stuff you need to do for changing the configuratioj
func_set_system_config_librarybox_ftpadmin(){
	local value=$1 ; shift
	local old_value=$1; shift

	echo "Changing ftp-admin access for LibraryBox"
	sed "s|ADMIN_ACCESS=\"$old_value\"|ADMIN_ACCESS=\"$value\"|" -i $ftp_config

}


#This function is called to compare content and et differences
#  to initiate a restart in the end, set "changed=1"
#  the easiest comparison can be used with auto_default_compare
#  see below
func_compare_and_set_librarybox_ftpadmin(){

        auto_config_lookup_and_set  "$librarybox_ftpadmin_myself" \
                "$cfg_auto_folder/$librarybox_ftpadmin_config_file" \
                "$cfg_tmp_folder/$librarybox_ftpadmin_config_file"

}
