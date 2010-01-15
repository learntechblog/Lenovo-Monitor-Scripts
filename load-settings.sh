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
sleep 2;

# Reset, then import panels xml if it's there
gconftool --load "$SCRIPTPATH/blank-panels.xml"
# Wait 2 seconds
sleep 2;
gconftool --load "$SCRIPTPATH/$1/panels.xml"
gconftool --load "$SCRIPTPATH/$1/panels.xml"
# I've had issues with gconftool not loading my panels correctly, 
# the second call seems to fix this.
