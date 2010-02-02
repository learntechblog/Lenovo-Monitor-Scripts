#!/bin/bash
currentuser=`whoami`
SCRIPTPATH="/home/$currentuser/Monitor"

echo "Loading $1 monitor settings"

# Is there a folder with the name of argument 1?
if [ -d $1 ]; then
	echo "Found a $1 folder";
else
	echo "Folder $1 does not exist, exiting.";
	exit 1;
fi

# Import disper settings if they exist
disper -i < "$SCRIPTPATH/$1/disper-settings"

# Reset, then import panels xml if it's there
gconftool --load "$SCRIPTPATH/blank-panels.xml"
gconftool --load "$SCRIPTPATH/$1/panels.xml"

# Sometimes the first load attempt fails, so try again.
gconftool --load "$SCRIPTPATH/$1/panels.xml"
# I've had issues with gconftool not loading my panels correctly, 
# the second call seems to fix this.
