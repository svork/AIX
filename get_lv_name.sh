#!/bin/ksh

# This script will read a list of mount points, using a FOR
# and then get their LV name, LV size(GB) and VG name

# rc699t - 2016/05/09

# variables
hostname > output_file.txt
date >> output_file.txt

# Read the mount points list
for mount_point in `cat mount_points_list.txt`; do

        # mount point - test
        #mount_point="/db2/db200005/bsdb/arclog"

        # get LV name
        lv_name=`df -g $mount_point | egrep "^/" | cut -d "/" -f3 | cut -d " " -f1`

        # get LV size
        lv_size=`df -g $mount_point | egrep "^/" | awk {'print $2'}`

        # get VG name
        vg_name=`lslv $lv_name | grep -i "group" | cut -d ":" -f3`

        # appending the output
        echo "$mount_point\t $lv_name\t $lv_size\t $vg_name" >> output_file.txt

done