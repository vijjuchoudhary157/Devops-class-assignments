#!/bin/bash
echo "starting backup process...."
echo "-----------------------"
if [ $# -lt 2 ]; then
	echo "usage: $0 <sourcedir> <backup_name>"
	exit 1
fi

sourcedir=$1
backupname=$2
echo "Source directory: $sourcedir"
echo "Backup name: $backupname"

echo "checking if the source directory exists or not:"
if [ -d "$sourcedir" ]; then
	echo "dir already exists"
else 
	mkdir -p "$sourcedir"
fi

backupfolder="$WORKSPACE/backups"

if [ ! -d "$backupfolder" ]; then
	echo "creating backup folder...."
	mkdir -p "$backupfolder"
fi

tar -czf "$backupfolder/$backupname.tar.gz" -C "$sourcedir" .
echo "backup file created: $backupfolder/$backupname.tar.gz"
echo "Backup completed successfully"
