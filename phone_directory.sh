#!/usr/bin/env bash
# BashPhoneBook v1.0
# Coded by: BHMBS IBRAHIM Student At ISET Nabeul - Tunisia
# Github: https://github.com/barhouum7/BashPhoneBook


trap 'printf "\n";stop;exit 1' 2
trap user_interrupt SIGINT
trap user_interrupt SIGTSTP

user_interrupt(){
        printf "\e[0m\n"
        printf "\n\e[0m\e[1;36m\t   Exiting... THANK YOU! (❁'◡'❁)\n"
        sleep 1
        # (for i in $(seq 0 10 100); do echo $i; sleep 1; done) | zenity --progress --title "Bye! THANK YOu!" -- auto-close
        printf "\e[0m\n"
        exit 1
}


stop() {

checkmongo=$(ps aux | grep -o "mongo" | head -n1)
if [[ $checkmongo == *'mongo'* ]]; then
pkill -f -2 mongo > /dev/null 2>&1
killall mongo > /dev/null 2>&1
fi
checkmongod=$(ps aux | grep -o "mongod" | head -n1)
if [[ $checkmongod == *'mongod'* ]]; then
pkill -f -2 mongod > /dev/null 2>&1
killall mongod > /dev/null 2>&1
fi
checkmongosh=$(ps aux | grep -o "mongosh" | head -n1)
if [[ $checkmongosh == *'mongosh'* ]]; then
pkill -f -2 mongosh > /dev/null 2>&1
killall mongosh > /dev/null 2>&1
fi
}

banner() {

printf "\n" | pv -qL 1000
printf "\n" | pv -qL 1000
printf "\n" | pv -qL 1000
printf "\e[1;90m     ____   __  __ __   ___  ____  _____    ____  __                  __     _            \e[0m\n" | pv -qL 1000
printf "\e[1;91m    / __ ) / / / //  |_/  / / __ )/ ___/   /  _/ / /_   _____ ____,_ / /_   (_)________  \e[0m\n" | pv -qL 1000
printf "\e[1;92m   / __ | / /_/ // / |_/ / / __  |\__ \    / /  / __ \ / ___// __  // __ \ / // __  __ \ \e[0m\n" | pv -qL 1000
printf "\e[1;94m  / /_/ // __  // /  /  / / /_/ /___/ /  _/ /  / /_/ // /   / /_/ // / / // // / / / / / \e[0m\n" | pv -qL 1000
printf "\e[1;90m /_____//_/ /_//_/  /__/ /_____//____/  /___/ /_.___//_/    \__,_//_/ /_//_//_/ /_/ /_/  \e[0m\n" | pv -qL 1000
printf "\e[1;90m                                                                                              v1.0\e[0m\n" | pv -qL 1000
printf "\n" | pv -qL 1000
printf "\e[1;93m              .:.:.\e[0m\e[1;77m The\e[0m\e[1;95m BashPhoneBook\e[0m\e[1;77m Script coded by:\e[0m\e[1;95m GitHub@barhouum7 \e[0m\e[1;93m.:.:.\e[0m\n" | pv -qL 1000
printf "\n" | pv -qL 1000
printf "      \e[101m\e[1;77m::                                                                          ::\e[0m\n" | pv -qL 1000
printf "      \e[101m\e[1;77m::          Bash implementation of a Phone Book Management System           ::\e[0m\n" | pv -qL 1000
printf "      \e[101m\e[1;77m::                                                                          ::\e[0m\n" | pv -qL 1000
printf "\n"

}


connectMongoCluster() {
	mongo "mongodb+srv://cluster0.r1vmd.mongodb.net:27017/phoneBookDb" --username myDbAdmin --password 5XCOpPTPOulWGrHV --eval "var document = { firstName: '$contact_firstName', lastName: '$contact_lastName', gender: '$contact_gender', phoneNumber: '$contact_number', email: '$contact_email', address: '$contact_address' }; db.contacts.insertOne(document);"
}



addContact() {

			printf "\e[1;96m                  Add NEW CONTACT \e[0m\n\n"
		
		# contactId, first name, father's name, gender, phone number, email, and address
		while true
		do
		read -p $'\n\e[1;96m ->\e[0m Enter Contact Id: ' contact_ID
		
		# Validate if any input field is left blank. If an input field is left blank, display appropriate message and stop execution of script
		if [[ -z "$contact_ID" ]]; then
			printf "\n\e[31m Inputs cannot be blank please try again!\e[0m\n"
		else #..................................>>>>>|else	
		findID=">"$contact_ID
		result=$(grep -nE $findID phoneBook.log)
		if [[ -e phoneBook.log && !( -z "$result") ]]; then
			printf "\n\e[31m Contact ID is used! Enter another ID.\e[0m\n"
		else #..................................>>>>>|else
		# Now Validate if the Contact ID is a number using regex (Integer). If not, display appropriate message and stop execution of the script
		if ! [[ "$contact_ID" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			printf "\n\e[31m Contact ID must be a number!\e[0m\n"
		else #..................................>>>>>|else
			# echo "Contact ID validated successfully.." Debugging...
        break
		fi #..................................>>>>>|fi
		fi #..................................>>>>>|fi
		fi #..................................>>>>>|fi
		done

		############################# I will Add Validation for those inputs Later .......#####################################
		read -p $'\n\e[1;96m ->\e[0m Enter First Name: ' contact_firstName
		read -p $'\n\e[1;96m ->\e[0m Enter Last Name: ' contact_lastName
		read -p $'\n\e[1;96m ->\e[0m Enter Gender (M/F): ' contact_gender
		############################# I will Add Validation for those inputs Later .......#####################################
		read -p $'\n\e[1;96m ->\e[0m Enter Phone Number: ' contact_number
		read -p $'\n\e[1;96m ->\e[0m Enter E-mail (example@example.com): ' contact_email
		############################# I will Add Validation for those inputs Later .......#####################################
		read -p $'\n\e[1;96m ->\e[0m Enter Address: ' contact_address
		printf "\n\e[32m Got That! ✔\e[0m\n\n"
		sleep 2
		clear
		printf "\e[1;96m                  NEW CONTACT INFO: \e[0m\n"
		printf "\n\e[1;90m ->\e[0m Contact ID: $contact_ID"
		printf "\n\e[1;90m ->\e[0m First Name: $contact_firstName"
		printf "\n\e[1;90m ->\e[0m Last Name: $contact_lastName"
		printf "\n\e[1;90m ->\e[0m Gender: $contact_gender"
		printf "\n\e[1;90m ->\e[0m Phone Number: $contact_number"
		printf "\n\e[1;90m ->\e[0m E-mail: $contact_email"
		printf "\n\e[1;90m ->\e[0m Address: $contact_address"
		echo "->$contact_ID : $contact_firstName : $contact_lastName : $contact_gender : $contact_number : $contact_email : $contact_address" >> phoneBook.log
		printf "\n\t\e[1;32m - Contact has been saved successfully! ✔\e[0m\n\n"
		lolcat phoneBook.log

}



searchForContact() {
			printf "\e[1;96m                  SEARCH FOR CONTACT \e[0m\n\n"
		while true
		do
		read -p $'\n\e[1;96m ->\e[0m Enter any query for contact to search: ' search_query
		clear
		printf "\e[33mPress \e[0m\e[1;33mCTRL+C \e[0m\e[33mOR \e[0m\e[1;33mCTRL+Z \e[0m\e[33mto Exit.\e[0m\n\n"
		printf "\e[1;96m                  SEARCH RESULTS: \e[0m\n\n"
		if [[ -z "$search_query" ]]; then
			printf "\n\e[31m Please enter contact's ID or any related info to SEARCH!\e[0m\n"
		else
		if [[ $search_query =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			searchQuery=">"$search_query
			if [ head -c 10 phoneBook.log > /dev/null 2>&1 ] | grep -i $searchQuery phoneBook.log > /dev/null 2>&1;then
			check_query=`cat phoneBook.log | grep -ci $searchQuery`
			#printf $check_query
			
			if [[ $check_query > 0 ]]; then printf "\e[32m The desired contact has been found! ✔\e[0m\n\n"; else printf "\e[31m I cannot find any contact with this ID. Please, Try again!\e[0m\n\n\n"; fi
			grep -i --color=always $searchQuery phoneBook.log
			else
			check_query=`cat phoneBook.log | grep -ci $search_query`
			#printf $check_query
			
			if [[ $check_query > 0 ]]; then printf "\e[32m The desired contact has been found! ✔\e[0m\n\n"; else printf "\e[31m I cannot find any contact with this information. Please, Try again!\e[0m\n\n\n"; fi
			grep -i --color=always $search_query phoneBook.log
			fi
		else
		if ! [[ $search_query =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			check_query=`cat phoneBook.log | grep -ci $search_query`
			#printf $check_query
			
			if [[ $check_query > 0 ]]; then printf "\e[32m The desired contact has been found! ✔\e[0m\n\n"; else printf "\e[31m I cannot find any contact with this information. Please, Try again!\e[0m\n\n\n"; fi
			grep -i --color=always $search_query phoneBook.log
		else
			break
		fi
		fi
		fi
		done
}



editContact() {
				printf "\e[1;96m                  	EDIT CONTACT INFO \e[0m\n\n"
		while true
		do
		printf "\e[33mPress \e[0m\e[1;33mCTRL+C \e[0m\e[33mOR \e[0m\e[1;33mCTRL+Z \e[0m\e[33mto Exit.\e[0m\n\n"
		printf "\e[1;96mYOUR PHONE BOOK: \e[0m\n\n"
		lolcat phoneBook.log
		read -p $'\n\e[1;96m ->\e[0m Enter ID of the contact: ' getContactId
		read -p $'\n\e[1;96m ->\e[0m Enter what do you want to change in this contact info: ' old_pattern
		read -p $'\n\e[1;96m ->\e[0m Enter the new info: ' new_pattern


		if [[ -z "$getContactId" || -z "$old_pattern" || -z "$new_pattern" ]]; then
			printf "\n\e[31m Please, enter contact's ID to EDIT!\e[0m\n"
			printf "\n\e[31m These fields are required to EDIT!\e[0m\n\n"
			sleep 2
			clear
		else
		if [[ $getContactId =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			searchForId=">"$getContactId
			if [ head -c 10 phoneBook.log > /dev/null 2>&1 ] | grep -i $searchForId phoneBook.log > /dev/null 2>&1;then
			check_query=`cat phoneBook.log | grep -ci $searchForId`
			if [[ $check_query > 0 ]]; then printf "\n\e[32m The desired contact has been found! ✔\e[0m\n\n"; else printf "\n\e[31m I cannot find any contact with this ID. Please, Try again!\e[0m\n\n\n"; fi
			sleep 2
			
			lineNumber=`grep -nc $searchForId phoneBook.log` # Also I can use this command for this purpose: awk '/$searchForId/{print NR}' phoneBook.log
			#printf $lineNumber
			printf "\n\n"
			sed -i phoneBook.log -e "$lineNumber s/$old_pattern/$new_pattern/"

			fi
		else
		if ! [[ $getContactId =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			printf "\n\e[31m Contact ID must be a number!\e[0m\n"
		else
			break
		fi
		fi
		fi
		done
}

deleteContact() {
			printf "\e[1;96m                  DELETE CONTACT \e[0m\n\n"
		while true
		do
		read -p $'\n\e[1;96m ->\e[0m Enter the contact`s ID or any related info to DELETE it (Case-sensitive): ' delete_query
		clear
		printf "\e[33mPress \e[0m\e[1;33mCTRL+C \e[0m\e[33mOR \e[0m\e[1;33mCTRL+Z \e[0m\e[33mto Exit.\e[0m\n\n"
		
		if [[ -z "$delete_query" ]]; then
			printf "\n\e[31m Please enter contact's ID or any related info to DELETE!\e[0m\n"
		else
		if [[ $delete_query =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			deleteQuery=">"$delete_query
			if [ head -c 10 phoneBook.log > /dev/null 2>&1 ] | grep -i $deleteQuery phoneBook.log > /dev/null 2>&1;then
			sed -i -e "/$deleteQuery/d" phoneBook.log
			printf "\n\e[32m DELETED Successfully! ✔\e[0m\n\n"
			sleep 2
			# clear
			printf "\t\e[1;96m                  PHONE BOOK NOW: \e[0m\n"
			lolcat phoneBook.log
			else
			sed -i -e "/$delete_query/d" phoneBook.log
			printf "\n\e[32m DELETED Successfully! ✔\e[0m\n\n"
			sleep 2
			# clear
			printf "\t\e[1;96m                  PHONE BOOK NOW: \e[0m\n"
			lolcat phoneBook.log
			fi
		else
		if ! [[ $delete_query =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			check_query=`cat phoneBook.log | grep -c $delete_query`
			printf $check_query
			
			if [[ $check_query > 0 ]]; then printf "\e[32m DELETED Successfully! ✔\e[0m\n\n"; else printf "\e[31m I cannot find any contact with this information. Please, Try again!\e[0m\n\n\n"; fi
			sed -i -e "/$delete_query/d" phoneBook.log # huuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuraaaay :((
			sleep 2
			# clear
			printf "\t\e[1;96m                  PHONE BOOK NOW: \e[0m\n"
			lolcat phoneBook.log
		else
			break
		fi
		fi
		fi
		done

}

listContacts() {
		printf "\e[1;96m                  YOUR PHONE BOOK \e[0m\n\n"
		lolcat phoneBook.log
}

startMyScript() {
	printf "                   \e[1;90m     Welcome to my\e[0m\e[1;95m Phone Book\e[0m\e[1;90m Management System!    \e[0m\n" | pv -qL 100
	printf "\n"
	printf "\e[1;33m pkg - \e[0m\e[33m Install Packages\e[0m\n" | pv -qL 100
	printf "\n\e[1;33m add - \e[0m\e[1;33m ADD \e[0m\e[33ma Contact\e[0m\n" | pv -qL 100
	printf "\e[1;33m src - \e[0m\e[1;33m SEARCH \e[0m\e[33mFor a Contact\e[0m\n" | pv -qL 100
	printf "\e[1;33m edt - \e[0m\e[1;33m EDIT \e[0m\e[33m a Contact Info\e[0m\n" | pv -qL 100
	printf "\e[1;33m dlt - \e[0m\e[1;33m DELETE \e[0m\e[33ma Contact\e[0m\n" | pv -qL 100
	printf "\e[1;33m dis - \e[0m\e[1;33m DISPLAY \e[0m\e[33mthe Phone Book\e[0m\n" | pv -qL 100
	printf "\n\n\e[33m Press \e[0m\e[1;33mq \e[0m\e[33mOR \e[0m\e[1;33mCTRL+C \e[0m\e[33mto Exit.\e[0m\n\n" | pv -qL 100
	
	read -p $'\e[1;96m->\e[0m Enter your choice: ' user_choice
	clear
	
	case $user_choice in
	pkg)
		clear
		chmod 777 install.sh
		./install.sh
		
	;;
	
	add)
		addContact
		({ printf >&2  "\n\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92mConnecting to MongoDB Cluster, please wait...\n\e[0m"; apt-get update > /dev/null || printf "\n\n\e[1;91mConnection Failed!\n\n\e[0m"; }) & wait $!
		connectMongoCluster
	;;
	
	src)
		searchForContact
	;;
	
	edt)
		editContact
	;;
	
	dlt)
		deleteContact
	;;
	
	dis)
		listContacts
		# echo "->$contact_ID : $contact_firstName : $contact_lastName : $contact_gender : $contact_number : $contact_email : $contact_address"
	;;
	
	q)
		user_interrupt
	;;
	

	*)
		printf "\n\e[31m INVALID OPTION! ❌\e[0m\n"
	;;
	esac;
	read -p $'\n\n\e[1;96m ->\e[0m Press q to exit, Press Enter OR Anything else to Return to Main Menu: ' is_exit
	if [[ $is_exit == "q" ]];
	then user_interrupt
	fi
	clear
}

clear
# touch phoneBook.log
# touch idField.txt
while :
do
banner
startMyScript
done