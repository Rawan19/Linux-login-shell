#full implementation for add group and delete group: groupname only;ADD ID
clear
echo "Main Menu"


function addgroup {
	if [[ -f "groups" ]]
	then
		
		read -p 'Group name: '  grpname
		if  cat groups | grep -wq $grpname 
		then
			echo "The name you entered already exists. Please try again"
			
		else
		
			echo $grpname >>groups
		fi		
						
	else
		echo "not exists"
		sudo touch groups
	fi
}

function removegroup {
	#prompt user for input
	read -p 'Group name: '  grpname

	#if the group has at least one user(length of first user is greater than 1)
	#, display a message that denies deletion.
	firstUserLength=$(cat groups| grep -w $grpname | awk -F: '{print $2}' | wc -c)
	
	if [[ $firstUserLength > 1 ]] 
	then
		echo "This group contains users. Thereby, it cannot be deleted."
	#if group doesn't exist (length =0)
	elif [[ $firstUserLength = 0 ]]
	then
		echo "This group doesn't exist."

	else
		#delete group
		sed -i "/$grpname/d" groups
		#delete white spaces 
		sed -i '/^$/d' groups 		
		echo "Group deleted"
	fi	
}

function testlogin {
	read -p 'Username: ' uname
	read -p 'Password: ' pass
	
	userLine=0
	#if user exists in users file
	if  cat users | grep -wq  $uname 
	then
		#get the line number of that user
		#userLine=$(cat users | awk "/$uname/{print NR;}")

		#compare passwords
		realPass=$(cat users | grep -w  rawan | awk -F: '{print $2;}')
		
		if [[ $realPass = $pass ]]
		then 
			echo "Logged in!"
			
			#change prompt
			userGroup=$(cat users | grep -w  rawan | awk -F: '{print $4;}')
			PS3=$uname" "$userGroup

		else
			echo "Wrong password"
		fi
			
	else
		echo "incorrecto username"
	fi
}
select task in AddUser AddGroup RemoveUser RemoveGroup TestLogin ChangeUserPassword Exit
do

	 if [[ $task == "AddGroup" ]]
        then
                addgroup
        fi


	if [[ $task == "RemoveGroup" ]]
	then
		removegroup
	fi
	
	if [[ $task == "TestLogin" ]]
	then 	
		testlogin
	fi

	if [[ $task == "Exit" ]]
	then
		exit
	fi

done
