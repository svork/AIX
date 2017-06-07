#!/bin/ksh

# Uncomment the below line to enable the debug mode
# set -x

# Purpose: This script is intended to create MKSYSB images
# automatically on a monthly basis. The image is then compressed
# using compress. The output should be placed 
# on rcipams1:/export/mksysb/backups/

# Rodrigo Costa - rc699t - 05/17/16


# Variables

	# hostname
	HOSTNAME="$(hostname)"

	# mksysb
	MKSYSB="/usr/bin/mksysb"

	# oslevel -s
	OSLEVEL="$(/usr/bin/oslevel -s)"

	# Local directory, it will hold the output files 
	LOCAL_DIR="/mksysb_dir"

	# NIM Server
	NIM_SERVER="rcipams1.ims.att.com"

	# NIM mount point 
	NIM_DIR="/export/mksysb/bkups"

	# compress
	COMPRESS="/usr/bin/compress"	

	# mail
	MAIL="/usr/bin/mail"

	# grep
	GREP="/usr/bin/grep"

	# date
	DATE="/usr/bin/date"

	# mount
	MOUNT="/usr/sbin/mount"

	# mksysb image name
	MKSYSB_IMAGE="$HOSTNAME"_"$OSLEVEL"_"$($DATE +'%Y%m%d').mksysb"

	# LOG_FILE
        LOG_FILE="$HOSTNAME"_"$OSLEVEL"_"$($DATE +'%Y%m%d').log"


# Starting the log file 
$DATE > $LOCAL_DIR/logs/$LOG_FILE
	
# Creating the /etc/exclude.rootvg file to remove /tmp/ from mksysb
echo "/tmp/" > /etc/exclude.rootvg 


# Check if the NIM_DIR is mounted, if is not, Mount it, else go ahead
$MOUNT | $GREP $LOCAL_DIR > /dev/null

RC=$?

if [ $RC -ne 0 ]; then

	# The NIM_DIR is not mounted, we must mount it
	$MOUNT $NIM_SERVER:$NIM_DIR $LOCAL_DIR

	RC_0=$?

	# check if the mount went ok
	if [ $RC_0 -ne 0 ]; then

		# mount has failed, exiting
		echo "Mount has failed" >> $LOCAL_DIR/logs/$LOG_FILE
		exit 1

	else

		# mount went fine, good
		echo "Mount went fine" >> $LOCAL_DIR/logs/$LOG_FILE

	fi

else

	# LOCAL_DIR is mounted, we are ok	
	echo "$LOCAL_DIR is mounted already" >> $LOCAL_DIR/logs/$LOG_FILE

fi

# Check if the LOCAL_DIR has at least 20 GB of free space
FREE_SPACE="$(df -g $LOCAL_DIR | awk {'print $3'} | tail -1 | cut -d "." -f1)"

if [ $FREE_SPACE -lt 20 ]; then

	# LOCAL_DIR has less than 20 GB, this is bad
	echo "$LOCAL_DIR has less than 20 GB" >> $LOCAL_DIR/logs/$LOG_FILE 

	exit 1

else
	
	# NIM_DIR is mounted and it has at least 20 GB of free space, creating the backup 
	$MKSYSB -e -i -p -v $LOCAL_DIR/$MKSYSB_IMAGE >> $LOCAL_DIR/logs/$LOG_FILE 2>&1 

	# Test the return code of the mksysb
	RC_1=$?

	# Compress the newly created mksysb image, using compress 
	$COMPRESS -v $LOCAL_DIR/$MKSYSB_IMAGE >> $LOCAL_DIR/logs/$LOG_FILE 2>&1 

	# Test the return code of the compress 
	RC_2=$?

	if [[ $RC_1 -eq 0 && $RC_2 -eq 0 ]]; then
		
		# mksysb went fine, sending an email to the SA team
		$MAIL -s "mksysb has been succesfully completed on $HOSTNAME" jfontes@br.ibm.com ulissesn@br.ibm.com rolimac@br.ibm.com < /dev/null 

	else

		# mksysb has failed, sending an email to the SA team	
		$MAIL -s "mksysb has failed on $HOSTNAME" jfontes@br.ibm.com ulissesn@br.ibm.com rolimac@br.ibm.com < /dev/null 

	fi

fi
