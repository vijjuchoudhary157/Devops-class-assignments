#!/bin/bash
echo "---THIS IS A HEALTH MANAGEMENT SYSTEM---"
echo "----------------------------------------"

#System Health Check
#Display disk usage, CPU info, and memory usage.
#Save the output to system_report.txt.
#Show only the first 10 lines of the report.

function System_health_check(){
        filename=system_report.txt
        if [ -f system_report.txt ]; then
                echo "system_report.txt already exists. Overwriting..."
        fi
        echo "System health:" > $filename
echo "Disk Usage:" >> $filename
echo "" >> $filename
df -h >> $filename

echo "CPU Usage" >> $filename
echo "" >> $filename
lscpu >> $filename
echo "Memory usage" >> $filename
echo "" >> $filename
free -h >> $filename
head -n 10 $filename

}
function Active_processes(){
        echo "Displaying active processes"
        echo ""
        ps -ef
        echo ""
        read -p "Enter the keyword you want to find in processes: " pro
        ps -ef | grep "$pro"
        echo ""
        echo "the no. of processes with keyword : '$pro' :"
        ps -ef | grep "$pro" | awk 'END { print NR }'


}

function User_group_management(){
        read -p "add username : " user
        if id "$user" &>/dev/null; then
                echo "user already exists"
 else
                 sudo useradd -m "$user"
                 echo "$user:12345" | sudo chpasswd
                 echo "user created with default password 12345 "
        fi
        echo ""

        read -p "name of the group: " groupname
        if getent group "$groupname" >/dev/null; then
                echo "group already exists"
        else
                sudo groupadd "$groupname"
                echo "Group created"
        fi
        sudo usermod -aG "$groupname" "$user"
        echo "User '$user' added to group '$groupname'"
        touch testfile.txt
        sudo chown "$user:$groupname" testfile.txt


}


function file_Organizer(){

        read -p "Enter the directory path: " directory_path
        echo ""
        if [ ! -d "$directory_path/images" ]; then

                mkdir $directory_path/images
                echo "$directory_path/images created"
        fi
        if [ ! -d "$directory_path/docs" ]; then

                mkdir $directory_path/docs
                echo "$directory_path/docs created"
        fi
        if [ ! -d "$directory_path/scripts" ]; then

                mkdir $directory_path/scripts
                echo "$directory_path/scripts created"
        fi
        echo ""
        echo " Moving files....."
mv "$directory_path"/*.jpg "$directory_path/images/" 2>/dev/null
        mv "$directory_path"/*.png "$directory_path/images/" 2>/dev/null
        mv "$directory_path"/*.txt "$directory_path/docs/" 2>/dev/null
        mv "$directory_path"/*.md "$directory_path/docs/" 2>/dev/null
        mv "$directory_path"/*.sh "$directory_path/scripts/" 2>/dev/null
        echo ""

        command -v tree >/dev/null 2>&1 || sudo apt install -y tree
        tree "$directory_path"

}

function Network_diagnostics(){
logfile=network_report.txt
echo "======================" >> "$logfile"
echo " pinging google " >> "$logfile"
echo "" >> "$logfile"
ping -c 3 www.google.com >> "$logfile" 2>&1
echo "resolving DNS " >> "$logfile"
echo "" >> "$logfile"
dig google.com >> "$logfile" 2>&1
echo "" >> "$logfile"
echo "Headers" >> "$logfile"
curl -I https://example.com >> "$logfile" 2>&1

}

function Scheduled_Task_Setup(){
        read -p "Enter minute (0-59)" minute
        read -p "Enter hour (0-23)" hour
        read -p "Enter the script path" script_path
        chmod 744 "$script_path"
        echo "Add this line to crontab (crontab -e):"
        echo "$minute $hour * * * $script_path"
}

function SSH_Key_Setup(){
        echo "generating a new ssh key :"
        ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
        echo ""
        echo "displaying public key; "
        cat ~/.ssh/id_rsa.pub
        echo ""
        echo "to copy this public key to a remote server : "
        echo " use the command ->  ssh-copy-id user@remote_host"
}

while true; do
        echo "Menu- Please select a funtion:"
        echo "----------------------------------------"
echo "1) System_health_check"
echo "2) Active_processes"
echo "3) User_group_management"
echo "4) file_Organizer"
echo "5) Network_diagnostics"
echo "6) Scheduled_Task_Setup"
echo "7) SSH_Key_Setup"
echo "8) Exit"

read -p "Enter choice: " usage
case  $usage in
        1) System_health_check ;;
        2) Active_processes ;;
        3) User_group_management ;;
        4) file_Organizer ;;
        5) Network_diagnostics ;;
        6) Scheduled_Task_Setup ;;
        7) SSH_Key_Setup ;;
        8) echo "GoodBye!"; exit 0 ;;
        *) echo "you did not select anything" ;;
esac
echo ""
echo "------------------------------------------"
done
