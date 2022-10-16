#!/bin/bash

function pack_num(){
	echo "Enter the package name you wanna search (you can give some keywords of your package name)"
	read keyword

	adb -s $device_name shell pm list packages | sed 's/package://g' | nl | grep -i "$keyword"
	echo
	echo "Press any key to continue"
	read
}

function remove_try_again(){
    echo "Do you want to try again?(Yy/Nn)"
    read try_again

    if [[ $try_again == 'y' || $try_again == 'Y' ]]
    then
      remove
    else
      loop
    fi
}

function check_temp(){
  re='^[0-9]+$'

  if [[ $temp -lt 1 || $temp -gt `adb -s $device_name shell pm list packages | wc -l` ]]
  then
    echo "Invalid number"
    remove_try_again

  elif ! [[ $temp =~ $re ]]  
  then
    echo "Not a number"
    remove_try_again
  fi
}

function remove(){
		adb -s $device_name shell pm list packages | sed 's/package://g' | nl
		echo
		echo "enter the package number"
		echo "SYNTAX [num1] [num2]...."
		echo

		read to_remove

    echo "Wait! preparing for the packages list to be removed."

		for temp in $to_remove; do
			to_remove_string="$to_remove_string `adb -s $device_name shell pm list packages | sed 's/package://g' | sed -n "$temp"p`"
      check_temp
		done

		echo "$to_remove_string" | tr " " "\n"
		echo -e "\nThese packages are going to be removed.\nDo you wish to continue?(y/n)"

		read option

		if [[ $option == "y" || $option == "Y" ]]
		then
			for temp in $to_remove_string; do
				if [[ `adb -s $device_name shell pm uninstall -k --user 0 $temp | grep -ow "Success"` == "Success" ]]
				then
					echo "$temp: uninstalled"
				else
					echo "$temp : failed"
				fi
			done
      to_remove_string=""
		else
      to_remove_string=""
			loop
		fi
}

function try_again_or_main_menu(){
	echo "Do you want to try again? (Yy/Nn)"
	read try_input

	if [[ $try_input == 'y' || $try_input == 'Y' ]]
	then
		echo
		more_than_one_device
	else
		loop
	fi
}
#
function to_check_valid_device_number(){
	number_of_lines=`adb devices | grep -w device | wc -l`
  re='^[0-9]+$'

  if [[ $number < 1 || $number > $number_of_lines ]]
  then
    echo "Invalid number"
    try_again_or_main_menu

  elif ! [[ $number =~ $re ]]
  then
    echo "Not a number"
    try_again_or_main_menu
  fi

	#if not valid return to more_than_one_device
}

function banner(){
echo   "  ██    ░██         ░██      ░██                     ░██                 "
echo   " ░██    ░██ ███████ ░██      ░██  ██████   ██████   ██████  █████  ██████"
echo   " ░██    ░██░░██░░░██░██████  ░██ ██░░░░██ ░░░░░░██ ░░░██░  ██░░░██░░██░░█"
echo   " ░██    ░██ ░██  ░██░██░░░██ ░██░██   ░██  ███████   ░██  ░███████ ░██ ░ "
echo   " ░██    ░██ ░██  ░██░██  ░██ ░██░██   ░██ ██░░░░██   ░██  ░██░░░░  ░██   "
echo   " ░░███████  ███  ░██░██████  ███░░██████ ░░████████  ░░██ ░░██████░███   "
echo   "  ░░░░░░░  ░░░   ░░ ░░░░░   ░░░  ░░░░░░   ░░░░░░░░    ░░   ░░░░░░ ░░░    "
echo   "                                        (made with ❤  by @anupamjaiswall)"
echo   "                              https://github.com/anupamjaiswall/Unbloater"
}

function more_than_one_device(){
	echo "More than one device found, select by giving a number"
	adb devices | grep -w device | sed 's/        device//g'| nl
	read number

	to_check_valid_device_number

	device_name=`adb devices | grep -w device | sed s/device// | sed -n "$number"p`
	loop
	echo
}

function backup(){
	total_package=`adb -s $device_name shell pm list packages | wc -l`
	count=1

	mkdir apk_backup
	cd apk_backup

	for package in $(adb -s $device_name shell pm list packages -3 | tr -d '\r' | sed 's/package://g');
	do
		apk=$(adb -s $device_name shell pm path $package | tr -d '\r' | sed 's/package://g');
		echo "($count/$total_package) Pulling $apk";
		adb pull -p $apk "$package".apk;
		let "count++"
	done

	cd ..
	echo "Backup created in apk_backup folder"
}

function device_selection(){
  echo "Enable usb debugging on your phone, then connect it with your pc and then press any key to continue :)"
  read 
  number_of_devices=`adb devices | grep -w device | wc -l`
  if [[ $number_of_devices == 1 ]]
  then 
    echo "found a device : "
    adb devices | grep -w device
    device_name=`adb devices | grep -w device | sed 's/	device//g'`
    echo

  elif [[ $number_of_devices > 1 ]]
  then
    more_than_one_device

  else
    echo "Either device not found or something bad occured"
    adb devices
    echo "exiting......."
    fi
}

function check_adb(){
  if ! command -v adb &> /dev/null
  then
    echo "Install adb first"
    loop
  fi
}

function loop(){
	while ((1))
	do
		echo
		echo "Select an option... "
		echo "0)   To install adb on debian based distros"
		echo "D/d) To detect or select a device"
		echo "1)   To enter adb shell (type \"exit\" when you want to exit)"
		echo "2)   To list packages"
		echo "3)   To remove package(s)"
		echo "4)   To search for package number"
		echo "5)   To install single or list of apk"
		echo "6)   To install multiple apk from a folder"
		echo "7)   To create backup(extraction of apk) of all apk"
		echo "8)   To create adb backup"
		echo "9)   To restore adb backup"
		echo "10)  To get help"
    echo "11)  Exit"
		read option

    #to check whether adb installed or not on selecting options except 0 and 10
    if [[ $option -le 9 && $option -ge 1 && $number_of_devices == 0 ]]
    then
      check_adb
      device_selection
    fi

		case $option in 
		0)	
			sudo apt update -y
			sudo apt install android-tools-adb -y
			echo
			;;

		D|d)
			device_selection
			echo
			;;
        
		1)
			adb -s $device_name shell
			;;
		
		2)	
			adb -s $device_name shell pm list packages | sed 's/package://g' | nl 
			echo "press any key continue"
			read
			;;

		3)
			remove
			;;

		4)
			pack_num
			;;

		7)
			backup
			;;

    10)
      echo "See the documentation : https://github.com/anupamjaiswall/Unbloater"
      ;;

		11)
			exit
			;;
		8)
			echo "allow from your device"
			adb -s $device_name shell 'bu backup -apk -all '> backup.adb
			echo "Created backup : backup.adb"
			;;
			
		9)
			echo "Enter backup file's full path(having .adb extention)"
			read backup_name
			
			if [ ! -f "$backup_name" ]
			then
				echo "$backup_name doesn't exist on specified location"
				loop
			fi

			echo "See your device"
			adb -s $device_name shell 'bu restore' < $backup_name
			;;

		5)
			echo "Enter path of the apk file(s)"
      echo "SYNTAX file1/path1/app.apk file2/path2/app2.apk\n"
			read file_with_path

			for temp in $file_with_path;
			do
			  if [ ! -f "$temp" ]
			  then
				  echo "$temp doesn't exist on specified location\n"
				  loop
			  fi

				adb -s $device_name install "$temp"
			done
			;;

		6)
			echo "Enter path of that directory"
      echo "SYNTAX /path/of/the/directory\n"
			read path
			#check for the path
			
			if [ ! -d "$path" ]
			then
				echo "$path doesn't exist on specified location"
				loop
			fi

			for file in $path/*
			do
				echo "installing $file\n"
				adb -s $device_name install $file
			done
			;;

		*) 
			echo "Invalid option!\n"
			;;
		esac
	done
}


#script starts from here
banner
number_of_devices=0
#to loop menu
loop
