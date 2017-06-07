#!/bin/ksh

# set -x

# This script is intended to remove mksysb files older than 3 months

# Rodrigo Costa - rc699t - 01-DEC-2016

# Variables
	
	DATE='/usr/bin/date'

	LOG_FILE=removed_old_mksysb_$($DATE +'%Y-%m-%d').log

	MKSYSB_DIR='/export/mksysb/bkups/'

	FIND='/usr/bin/find'

	FILE='/usr/bin/file'

	XARGS='/usr/bin/xargs'

	RM='/usr/bin/rm'

# Using find to retrieve and delete files older than 3 months

$FIND $MKSYSB_DIR -mtime +90 | $XARGS $FILE >> $LOG_FILE 2>&1
