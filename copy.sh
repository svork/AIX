#!/bin/ksh

# set -x

for i in $(cat servers.txt); do

	scp mksysb_script.tar rc699t@$i:$HOME 2>> log.file

done
