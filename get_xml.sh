#!/usr/bin/ksh

# -------- Info --------
# set -x

# This script is intended to retrieve data from an AIX server
# regarding SSH settings and export them to an XML file

# Rodrigo Costa - rc699t - 2017/FEB/10

# -------- Variables --------
OUT_FILE="/home/rc699t/$(hostname).xml"

# Creating the XML file
echo '<?xml version="1.0" encoding="UTF-8"?>' > $OUT_FILE

# IN_FILE - List of commands to be executed, one per line
IN_FILE="/home/rc699t/SSH_checklist_commands.txt"

# Row Number
ROW=19

# -------- Runtime --------
echo "<data>" >> $OUT_FILE

echo "<hostname>" >> $OUT_FILE

	hostname >> $OUT_FILE

echo "</hostname>" >> $OUT_FILE

# This while will read the list of commands
while read COMMAND; do

	echo "<row$ROW>" >> $OUT_FILE

		$COMMAND >> $OUT_FILE 2>&1

	echo "</row$ROW>" >> $OUT_FILE

	ROW=$(echo "$ROW+1" | bc)

done < $IN_FILE

echo "</data>"  >> $OUT_FILE

# Changing the ownership of the OUT_FILE to rc699t
chown rc699t:sadm $OUT_FILE
