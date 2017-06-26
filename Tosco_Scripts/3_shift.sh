#!/bin/bash

# this script will receive some parameters and then, using the SHIFT, remove the first item $1

# $# - the number of parameters

# $* - all the paremters separated by a white space

clear

if [ $1 ] ; then

	echo -e "\nYou have typed $# parameters\n";
	echo -e "They are: $*\n";
	echo -e "Now, I am going to remove the first one, $1\n";
	echo "Removing...";

	# shift removes the first item, $1
	shift

	echo -e "\nYour parameters are now $# : $*";
else

	echo -e "Error! You did not type any parameter.\n";

fi
