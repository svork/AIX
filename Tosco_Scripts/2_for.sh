#!/bin/bash

# script for test the FOR command and its syntax

# use a if to test the $1, it must exists. Else the script will fail

# $@ - all the parameters, separated by a white space

clear

if [ $1 ] ; then

	echo -e "You have typed $# parameters\n"

	for i in $@
	do
		echo "O valor do parametro: $i"
	done	
else
	echo "Error! You must type at least 1 parameter."
fi
