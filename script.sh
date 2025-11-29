#!/bin/bash
echo "--------SYSTEM MANAGER--------"
add_users(){
if [ "$@" -ne 2 ] 
then
    echo "usage:$0 add_users <usernames_file>"
    exit 1
fi
user_file="$1"
if [ ! -f "$user_file" ]; then
    echo "Error: File $user_file not found!"
    exit 1
fi

echo "Reading users from the file"
echo "..........................."
while read -r username
do
    if id "$username" &>/dev/null
    then
        echo "$username already exists"
    else
        sudo useradd -m "$username"
        echo "$username created"
    fi
done < "$user_file"
echo "users created"
echo "----------------------------"
}

setup_projects(){
if [ "$@" -lt 2 ]
	then 
		echo "usage:$0 setup_projects <username> <number_of_projects>"
		exit 1
fi
dirname=/home/parija/projects
if [ ! -d $dirname ] 
then 
	echo " making directory $dirname "
	mkdir $dirname
	echo "----------------------------"
	echo " Adding README.txt"
	if [ ! -f "$dirname/README.txt" ]
	then
		touch $dirname/README.txt
		echo "projects created by $USER on $(date)" > "$dirname/README.txt"
		
	else
		echo "file already exists"
		exit 1
	fi
	echo " making folders project_1 project_2 and project_3 "
	for (( i=1;i<=$2;i++ ))
	do
	mkdir -p "$dirname/project$i"
done

else
	echo "Directory already exists "
fi

chmod 755 "$dirname"
chmod 640 "$dirname/README.txt"

for (( i=1; i<=$2; i++ )); do
    chmod 755 "$dirname/project$i"
done
}

sys_report(){
if [ "$@" -eq 0 ]
then
       echo "usage:$0 sys_report <output_file>"
       exit 1
fi

infofilename=/home/parija/infofile.txt

if [ ! -f "$infofilename" ]
        then
                touch $infofilename
	else
		echo "file already exists"
fi
{
echo "------Disk usage-----"
df -h
echo "------Memory info-----"
free -mt
echo "------cpu info--------"
lscpu
echo "Top 5 memory-consuming processes"
ps aux --sort=-%mem | head -n 5 
echo "Top 5 cpu-consuming processes"
ps aux --sort=-%cpu | head -n 5
} > $infofilename

}
process_manage(){
	echo " list of actions are :list_zombies ,list_stopped ,kill_zombies ,kill_stopped "

if [ "$@" -eq 0 ] || [ "$@" -lt 2 ]
then
       echo "usage:$0 process_manage <username> <action>"
       exit 1
fi
action=$2 
if [ "$action" =  list_zombies ]
then 
	echo " Listing zombie_processes "
	ps aux | grep '[Z]'
elif [ "$action" = list_stopped ]
then
	echo " listing stopped "
       ps aux | awk '$8=="T"'

elif [ "$action" = kill_zombies ]
then
	echo "Cannot kill zombie processes directly,they are already dead"
elif [ "$action" = kill_stopped ]
then
	echo " killing stopped proccess "
else
echo "invalid action"
fi

}
perm_owner(){

username=$1
path=$2
permissions=$3
owner=$4
group=$5

if [ "$@" -ne 5 ]
then 
       echo "usage:$0 perm_owner <username> <path> <permissions> <owner> <group>"
fi
if [ ! -e "$path" ]; then
        echo "Error: Path $path does not exist."
        return 1
else
	mkdir $path
fi
echo " changing permissions"
chmod -R $permissions $path
echo " changing owership"
chown $owner:$group $path
echo " verifying .."
ls -ld $path

}
help(){

echo "--USAGE--"
echo "./sys_manager.sh add_users <usernames_file>"
echo "./sys_manager.sh setup_projects <username> <number_of_projects>"
echo "./sys_manager.sh sys_report <output_file>"
echo "./sys_manager.sh process_manage <username> <action>"
echo "./sys_manager.sh perm_owner <username> <path> <permissions> <owner> <group>"
echo "./sys_manager.sh help"

echo "--------------------------"
echo "Example USAGE: "
echo "./sys_manager.sh add_users users.txt"
echo "./sys_manager.sh setup_projects alice 5"
echo "./sys_manager.sh sys_report sysinfo.txt"
echo "./sys_manager.sh process_manage bob list_zombies"
echo "./sys_manager.sh perm_owner alice /home/alice/projects 755 alice alice"
echo "./sys_manager.sh help"
}
case "$1" in
    add_users)
        add_users "$@"
        ;;
    setup_projects)
        setup_projects "$@"
        ;;
    sys_report)
        sys_report "$@"
        ;;
    process_manage)
        process_manage "$@"
        ;;
    perm_owner)
        perm_owner "$@"
        ;;
    help)
        help
        ;;
    *)
        echo "invalid"
        exit 1
        ;;
esac
