#!/bin/bash
currentuser=`whoami`
SCRIPTPATH="/home/$currentuser/Monitor"

echo "Saving $1 settings"

# Is there a folder with the name of argument 1?
if [ -d $1 ]; then
	# Prompt to overwrite
	read -p "Folder already exists. Do you want to overwrite? (y/n)"
	[ "$REPLY" == "y" ] || exit 1;
else
	echo "Folder $1 does not exist";
	mkdir "$SCRIPTPATH/$1"
fi

# Save disper settings
disper -p > "$SCRIPTPATH/$1/disper-settings"

# Check if the disper file got created and is more than X lines long
if [ ! -e "$SCRIPTPATH/$1/disper-settings" ]; then
	echo "disper file not created properly.";
fi

# Save panels
gconftool --dump /apps/panel > "$SCRIPTPATH/$1/panels.xml"

# Check if the panels xml file got created and is more than X lines long
if [ ! -e "$SCRIPTPATH/$1/panels.xml" ]; then
	echo "panels xml file not created properly.";
fi


