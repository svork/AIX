#!/bin/bash

#  on 2015-12-04

# This script is supposed to check the Wire lines on GA016A4BD hourly;
# and if a lines goes down, the script should try to bring it up.

# Any doubts? Please refer to procedures: 120214173017641 and 

# variables
# files used throughout the script

LINE_DOWN=/tmp/lineDown.txt;

LINE_NAME=/tmp/lineDownName.txt;

LINE_STATUS=/tmp/lineStatus.txt;

LINE_MAIL=/tmp/lineMail.txt;

# The script should only run, if $USER == mtsadm or id -u == 201

if [ `id -u` -eq 201 ]; then
	
	# Now changing to the area mtsprod12
	area mtsprod12;
	
	# FIXME - the area mtsprod12 seems to always return 0, even on failure
	# if success go ahead, else just die already
	if [ $? -eq 0 ]; then
	
		# issue the checkState command		
		if [ `checkState | grep -ci false` -gt 0 ]; then
		
			# issue the recycle S1line if the line is FALSE
			recycle S1line;
			
			# true = do nothing :)
			
		fi
	
		# issue the linecheck command, looking for DOWN lines
		if [ `linecheck | grep -ci down` -gt 0 ]; then
		
			# there is at least one line down; try to recover it

			# finding the lines down
			linecheck | grep -i down > $LINE_DOWN
			
			# getting the line names, using cut
			cat $LINE_DOWN | cut -d " " -f 3 | cut -d "/" -f 5 > $LINE_NAME
			
			# FOR will get the line name from each line
			for LINENAME in `cat $LINE_NAME`; do
				
				# trying to bring the lines UP
				linecmd -line $LINENAME -b 175 -up;
				
				# testing line status, up = good, down = bad
				linecmd -line $LINENAME -b 175 -show >> $LINE_STATUS
					
			done
			
			# ler status de cada linha, e se ainda estiver DOWN, mandar o email
			# FOR para ler N linhas e depois IF para mandar email ou dizer que o ENTEI passou para aqui, ou seja TA TUDO BEM AGORA
			
			if [ `grep -ci down $LINE_STATUS` -gt 0 ]; then
			
				# write the lines mail which remains down to the $LINE_MAIL
			
				# if the line is still down, send e-mail to DL, informing the line name			
				# the server GA016A4BD does not need the "echo -e". It understand the \t and \n already
							
				echo -e "\tHello Distributed Team,\n\n TEST! There is a wire line down. The script could not bring it back online.\n Please contact the WT-Wire-Transfer oncall person.\n The following line is down:\n" >> $LINE_MAIL && mail -s "Wire Line Check Failure" -r do-not-reply@suntrust.com rolimac < $LINE_MAIL
			
			fi
			
			# para testar no meu TP, usar um alias do tipo alias linecheck='cat mts' e alias area mtsprod12='echo "You are in "'
			# alias linecheck done :)
			# alias checkState done :)	
		fi
	else
	
		# if not on area mtsprod12
		echo "Error! You're not on < area mtsprod12 >. Please try again";
	
	fi
else

	# if not user mtsadm, exit
	echo "Error! You're not user < mtsadm >. Please try dzdo su - mtsadm";
	return 1;
	
fi
