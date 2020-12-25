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
        sleep 2
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

printf "\n"
printf "\n"
printf "\n"
printf "\e[1;90m     ____   __  __ __   ___  ____  _____    ____  __                  __     _            \e[0m\n"
printf "\e[1;91m    / __ ) / / / //  |_/  / / __ )/ ___/   /  _/ / /_   _____ ____,_ / /_   (_)________  \e[0m\n"
printf "\e[1;92m   / __ | / /_/ // / |_/ / / __  |\__ \    / /  / __ \ / ___// __  // __ \ / // __  __ \ \e[0m\n"
printf "\e[1;94m  / /_/ // __  // /  /  / / /_/ /___/ /  _/ /  / /_/ // /   / /_/ // / / // // / / / / / \e[0m\n"
printf "\e[1;90m /_____//_/ /_//_/  /__/ /_____//____/  /___/ /_.___//_/    \__,_//_/ /_//_//_/ /_/ /_/  \e[0m\n"
printf "\e[1;90m                                                                                              v1.0\e[0m\n"
printf "\n"
printf "\e[1;93m              .:.:.\e[0m\e[1;77m The\e[0m\e[1;95m BashPhoneBook\e[0m\e[1;77m Script coded by:\e[0m\e[1;95m GitHub@barhouum7 \e[0m\e[1;93m.:.:.\e[0m\n"
printf "\n"
printf "      \e[101m\e[1;77m::                                                                          ::\e[0m\n"
printf "      \e[101m\e[1;77m::          Bash implementation of a Phone Book Management System           ::\e[0m\n"
printf "      \e[101m\e[1;77m::                                                                          ::\e[0m\n"
printf "\n"

}


connectMongo() {
mongo --version
mongo --quiet <<EOF
show dbs;
use phoneBookDb;
EOF
mongo "mongodb+srv://cluster0.r1vmd.mongodb.net/phoneBookDb" --username myDbAdmin --password 5XCOpPTPOulWGrHV
#trap '' SIGINT SIGTSTP && command -v mongo > /dev/null 2>&1 ||
}

startMyScript() {
	printf "                   \e[1;90m     Welcome to my\e[0m\e[1;95m Phone Book\e[0m\e[1;90m Management System!    \e[0m\n"
	printf "\n"
	printf "\e[1;33m pkg - \e[0m\e[33m Install Packages\e[0m\n"
	printf "\n\e[1;33m 1 - \e[0m\e[1;33m Add \e[0m\e[33ma Contact\e[0m\n"
	printf "\e[1;33m 2 - \e[0m\e[1;33m Search \e[0m\e[33mFor a Contact\e[0m\n"
	printf "\e[1;33m 3 - \e[0m\e[1;33m Delete \e[0m\e[33ma Contact\e[0m\n"
	printf "\e[1;33m 4 - \e[0m\e[1;33m Display \e[0m\e[33mthe Phone Book\e[0m\n"
	printf "\n\n\e[33m Press \e[0m\e[1;33m5 \e[0m\e[33mOR \e[0m\e[1;33mCTRL+C \e[0m\e[33mto Exit.\e[0m\n\n"
	
	read -p $'\e[1;96m->\e[0m Enter your choice: ' user_choice
	clear
	
	case $user_choice in
	pkg)
		clear
		chmod 777 install.sh
		./install.sh
		({ printf >&2  "\n\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92mConnecting to MongoDB Cluster, please wait...\n\e[0m"; apt-get update > /dev/null && connectMongo > /dev/null || printf "\n\n\e[1;91mConnection Failed!\n\n\e[0m"; }) & wait $! 
		connectMongo
		
	;;
	
	1)
		printf "\e[1;96m                  Add NEW CONTACT \e[0m\n\n"
		# contactId, first name, father's name, gender, phone number, email, and address
		while ! [[ -z "$result" ]] || ! [[ "$contact_ID" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] || [[ -z "$contact_ID" ]]
		do
		read -p $'\n\e[1;96m ->\e[0m Enter Contact Id: ' contact_ID
		# Validate if any input field is left blank. If an input field is left blank, display appropriate message and stop execution of script
		if [[ -z "$contact_ID" ]]; then
			printf "\n\e[31m Inputs cannot be blank please try again!\e[0m\n"
			# kill $!
			sleep 1
		else #..................................>>>>>|else
		head -c 5 phoneBook.log > idField.txt
		result=$(grep -nE $contact_ID idField.txt)
		if ! [[ -z "$result" ]]; then
			printf "\n\e[31m Contact ID is used! Enter another ID.\e[0m\n"
			sleep 1
		fi
		# Now Validate if the Contact ID is a number using regex (Integer). If not, display appropriate message and stop execution of the script
		if ! [[ "$contact_ID" =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
			printf "\n\e[31m Contact ID must be a number!\e[0m\n"
			sleep 1
		fi
		# Validate if any input field is left blank. If an input field is left blank, display appropriate message and stop execution of script
		if [[ -z "$contact_ID" ]]; then
			printf "\n\e[31m Inputs cannot be blank please try again!\e[0m\n"
			# kill $!
			sleep 1			
		fi
		fi #..................................>>>>>|fi
		# printf "\n\e[32m Working...\e[0m\n\n"
		done
		read -p $'\n\e[1;96m ->\e[0m Enter First Name: ' contact_firstName
		read -p $'\n\e[1;96m ->\e[0m Enter Last Name: ' contact_lastName
		read -p $'\n\e[1;96m ->\e[0m Enter Gender (M/F): ' contact_gender
		
		
		read -p $'\n\e[1;96m ->\e[0m Enter Phone Number: ' contact_number
		read -p $'\n\e[1;96m ->\e[0m Enter E-mail (example@example.com): ' contact_email
		
		
		read -p $'\n\e[1;96m ->\e[0m Enter Address: ' contact_address
		printf "\n\e[32m Got That! ✔\e[0m\n\n"
		clear
		printf "\e[1;96m                  NEW CONTACT INFO \e[0m\n"
		printf "\n\e[1;90m ->\e[0m Contact ID: $contact_ID"
		printf "\n\e[1;90m ->\e[0m First Name: $contact_firstName"
		printf "\n\e[1;90m ->\e[0m Last Name: $contact_lastName"
		printf "\n\e[1;90m ->\e[0m Gender: $contact_gender"
		printf "\n\e[1;90m ->\e[0m Phone Number: $contact_number"
		printf "\n\e[1;90m ->\e[0m E-mail: $contact_email"
		printf "\n\e[1;90m ->\e[0m Address: $contact_address"
		echo "- $contact_ID : $contact_firstName : $contact_lastName : $contact_gender : $contact_number : $contact_email : $contact_address" >> phoneBook.log
		printf "\n\t\e[1;32m - Contact has been saved successfully! ✔\e[0m\n\n"
	;;
	
	2);;
	
	3);;
	
	4);;
	
	5)
		user_interrupt
	;;
	

	*)
		printf "\n\e[31m INVALID OPTION! ❌\e[0m\n"
	;;
	esac;
	read -p $'\n\n\e[1;96m ->\e[0m Press 5 to exit, Press Enter OR Anything else to Return to Main Menu: ' is_exit
	if [[ $is_exit -eq 5 ]];
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