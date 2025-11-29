#!/bin/bash
echo "This script is related to disk management"
echo " "

#Monitor disk, memory, and CPU usage using a cronjob every 10 minutes.
#If disk usage > 85%, RAM < 200MB, or CPU > 90%, send an email (or log the issue).
#Output logs to a dedicated /var/log/sys_monitor.log.

LOGFILE="/var/log/sys_monitor.log"
TO="parijajasharma16@gmail.com"
echo "------------------------"
echo "checking the disk usage "
echo "------------------------"
usagenum=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')
echo "you disk usage (%): $usagenum %"
echo "........................"
if [ "$usagenum" -le 85 ] 
then
	echo "No issues"
else
	echo "ISSUE!!! - sending email"
	echo "your disk is more 85% used !!!" | mail -s "disk alert" "$TO"

fi
echo "------------------------"
echo "checking the ram usage"
echo "------------------------"
ramusage=$(free -m | awk '/Mem:/ {print $7}')
echo "you ram usage (mb): $ramusage"
if [ "$ramusage" -le 200 ]
then
        echo "No issues"
else
        echo "ISSUE!!! - sending email"
        echo "your ram have less storage !!!" | mail -s "ram alert" "$TO"

fi

echo "------------------------"
echo "checking the cpu usage"
echo "------------------------"
cpusage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "you ram usage (mb): $cpusage"
if [ "$cpusage" > 90 ]; then
        echo "No issues"
else
        echo "ISSUE!!! - sending email"
        echo "your cpu usage is more than 90% !!!" | mail -s "cpu alert" "$TO"

fi
