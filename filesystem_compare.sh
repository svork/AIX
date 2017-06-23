#!/usr/bin/ksh

# The purpose of this script is to compare each file system, mount point and size
# and write it to a text file

#set -x # Debug mode

# Rodrigo Costa - rc699t - 2017-JUN-12

# Variables

	# Today's date
	DATE=$(date +'%Y-%b-%d_%H-%M')

	# Input file, taken from command line as a argument
	IN_FILE=$2

	# Output file
	OUT_FILE=$HOME/"$(hostname)_output_$DATE.txt"

	# Final results file
	RESULT=$HOME/"result_$DATE.txt"

	# Positional parameter, should be either "-c" or "-m"
	OPTION=$1

# make() Function - Reads the mount points details and output them to OUT_FILE
make(){

	hostname > "$OUT_FILE" 2>&1

	# List all but the rootvg volume group
	for VG in $(lsvg | grep -v "rootvg"); do

		# Reads local file systems, looking for its size and mount point only
		lsvgfs $VG | xargs df -g -T local | tail -n +2 | awk '{print $7, $2}' >> "$OUT_FILE" 2>&1

	done

	print "\nRead is complete!"
	print "Output : $OUT_FILE"
	return 0
}

# compare() Function - Compares local system to user provided file, IN_FILE
compare(){

	# If user did not provide an input file, print error and exit
	if [ "$1" = "" ]; then
	
		print "Error! You did not provide an input file"
		exit 1

	else
	
		# Create a local file, using function make()
		make

		# Compares IN_FILE with OUT_FILE
		diff "$IN_FILE" "$OUT_FILE" > "$RESULT" 2>&1		

		# If differences are found, print them
		if [ "$?" -ne 0 ]; then

			print "\nThe following differences have been found"
			cat "$RESULT"	

		else

			# All is good, the file systems have the same size
			print "\nThe file system sizes and mount points are exactly the same"			

		fi

		print "\nCompare is complete!"
	fi

	return 0
}


# Main function
main(){
	# If the user didn't provide any parameter, print help message and exit
	if [ "$OPTION" = "" ]; then

		# General Help
		print "Usage: ./filesystem_compare.sh <-m>  or  <-c file>"
		print " -m ( make ) - Creates the file system list"
		print " -c ( compare ) - Compares the file system list, using a provided text file"
		exit 1

	else
		# Usage 
		if [ "$OPTION" = "-m" ]; then

			# Reads local filesystems, size and mount name
			make

		elif [ "$OPTION" = "-c" ]; then
	
			# Compares the local system with the user provided file
			compare "$IN_FILE"
		
		else

			# User chose an invalid option
			print "Error! You chose an invalid option"
			exit 1

		fi

	fi
}

main
