#!/bin/sh
logfile="$WORKSPACE/script.log"
datetime=$(date "+Y-%m-%d %H:%M:%S")
echo " this will tell you the number of times this script executes "
echo "------------------------------------------------------------"
echo "This script was executed on $datetime"
if [ ! -f "$logfile" ]; then
	count=1;
else
	count=$(( $(wc -l < "$logfile") + 1 ))
fi

echo "$count | $datetime" >> "$logfile" 
echo "This script has been executed $count times."
