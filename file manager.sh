#!/bin/sh
echo "WELCOME TO fILEMANAGER"
echo "----------------------"
echo " "

addDir(){
path=$1
directory=$2
	if [ ! -d "$path/$directory" ]
	then
		mkdir -p "$path/$directory"
		echo "directory addded $path/$directory"
	else 
		echo "Directory already exists"
	fi
}
addFiles(){
path=$1
directory=$2
file=$3

if [ -d "$path/$directory" ]; then	
	if [ ! -f "$path/$directory/$file" ]; then
		touch "$path/$directory/$file"
		echo "File created: $path/$directory/$file"
	else
		echo "file already exist"
	fi
   else
	echo "Directory does not exists"
fi	
}

listFiles(){
path=$1
if [ -d "$path" ]
then
	echo "here is the files list: "
	echo " "
	( cd "$path" && find . -maxdepth 1 -type f )
else
	echo "No files found"
fi
}
listDirs(){
path=$1
if [ -d "$path" ]
then
	echo "here is the directory list: "
        echo " "

        ( cd $path && find . -maxdepth 1 -type d )
else
	echo "Directory do not  exists"
fi
}

listAll(){
path=$1
if [ -d "$path" ]
then
	echo "here is the list of all : "
        echo " "

        ( cd $path && ls -l )

else
	echo "Path does not exist"
fi
}
deleteDir(){
path=$1
directory=$2
	if [ ! -d "$path" ]
	then
		echo "Directory does not exist"
	else
		rm -r "$path/$directory"
		echo "directory deleted: $path/$directory"
	fi
}
addDir temp dir1
addDir temp dir2
addDir temp dir3
addFiles temp dir1 file1.txt
listFiles temp
listDirs temp
listAll temp
deleteDir temp dir1
