#!/bin/ksh

#set -x

Variables
	SERVER="server_name"

date > $(hostname).sudoers.list

for i in $(cat /etc/passwd | cut -d ":" -f1); do

	if [ $(grep $i /etc/sudoers >> /dev/null 2>&1; echo $?) -eq 0 ]; then

		echo $i >> $(hostname).sudoers.list

	fi

done

scp $(hostname).sudoers.list rc699t@$SERVER:/home/rc699t
