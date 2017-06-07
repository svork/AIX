#!/usr/bin/ksh

# set -x

# This script is intended to monitor the TSM Sched process and
# if necessary, start it again

# Rodrigo Costa - 12-DEC-2016

# Variables

	# TSM_SCHED_PATH - Path to start the TSM Scheduler
	TSM_SCHED_PATH="/usr/tivoli/tsm/client/ba/bin64/dsmc sched"

	# PS
	PS="/usr/bin/ps"

	# is TSM_SCHED running?
	TSM_SCHED="$($PS -ef | grep -v 'grep' | grep -i 'dsmc sched' > /dev/null 2>&1; echo $?)"

	# Hostname
	HOSTNAME="/usr/bin/hostname"

	# Mail
	MAIL="/usr/bin/mail"

	# Insert here the TSM Support email address and/or phone number
	MAIL_Address="evandrol@br.ibm.com wallaceg@br.ibm.com"

# Checking if the TSM Sched process is running, by evaluating its RC
if [ $TSM_SCHED -eq 0 ]; then

	# Do nothing, once the TSM Sched is running, this is good!
	exit 0

else

	# TSM Sched is not running, this is bad. Let me start it...
	$TSM_SCHED_PATH > /dev/null 2>&1 &

	# Return Code 0=True 1=False
	RC_1=$?

	# Checking if the TSM Sched were started
	if [ $RC_1 -eq 0 ]; then

		# Yay, TSM Sched has been successfully started
		exit 0

	else

		# TSM Sched has failed to start, this is no good
		# Notifying the TSM Support folks
		$MAIL -s "TSM Sched has failed to start on $HOSTNAME" $MAIL_Address < /dev/null

	fi

fi
