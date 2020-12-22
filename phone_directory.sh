#!/usr/bin/env bash
# BashPhoneBook v1.0
# Coded by: BHMBS IBRAHIM Student At ISET Nabeul - Tunisia
# Github: https://github.com/barhouum7/BashPhoneBook


trap 'printf "\n";stop;exit 1' 2

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
# # mongo --version
# mongo --quiet <<EOF
# show dbs;
# use phoneBookDb;
# EOF
# mongo "mongodb+srv://cluster0.r1vmd.mongodb.net/phoneBookDb" --username myDbAdmin --password 5XCOpPTPOulWGrHV
# Initialize a mongo data folder and logfile

mkdir -p /c/data/db/var/log
touch /c/data/db/var/log/mongodb.log

# Start mongodb with logging
# --logpath    Without this mongod will output all log information to the standard output.
# --logappend  Ensure mongod appends new entries to the end of the logfile. We create it first so that the below tail always finds something
/c/Program\ Files/MongoDB/Server/4.2/bin/mongod  --quiet --logpath /c/data/db/var/log/mongodb.log --logappend &

# Wait until mongo logs that it's ready (or timeout after 60s)
COUNTER=0
grep -q 'waiting for connections on port' /c/data/db/var/log/mongodb.log
while [[ $? -ne 0 && $COUNTER -lt 60 ]] ; do
    sleep 2
    let COUNTER+=2
    echo "Waiting for mongo to initialize... ($COUNTER seconds so far)"
    grep -q 'waiting for connections on port' /c/data/db/var/log/mongodb.log
done

# Now we know mongo is ready and can continue with other commands
}

startMyScript() {
	printf "                   \e[1;90m     Welcome to my\e[0m\e[1;95m Phone Book\e[0m\e[1;90m Management System!    \e[0m\n"
	printf "\n"
	printf "\e[1;33m 1 - \e[0m\e[33m Add a Contact\e[0m\n"
	printf "\e[1;33m 2 - \e[0m\e[33m Search For a Contact\e[0m\n"
	printf "\e[1;33m 3 - \e[0m\e[33m Delete a Contact\e[0m\n"
	printf "\e[1;33m 4 - \e[0m\e[33m Display the Phone Book\e[0m\n"
	printf "\e[1;33m 5 - \e[0m\e[33m Exit\e[0m\n"
	read -p $'\e[1;96m->\e[0m Enter your choice: ' user_choice
	clear
	
	case $user_choice in
	1)
		printf "\e[1;96m                  Add NEW CONTACT \e[0m\n\n"
		# first name, father's name, gender, phone number, email, and address
		read -p $'\n\e[1;96m ->\e[0m Enter First Name: ' contact_firstName
		read -p $'\n\e[1;96m ->\e[0m Enter Last Name: ' contact_lastName
		read -p $'\n\e[1;96m ->\e[0m Enter Gender (M/F): ' contact_gender
		read -p $'\n\e[1;96m ->\e[0m Enter Phone Number: ' contact_number
		read -p $'\n\e[1;96m ->\e[0m Enter E-mail (example@example.com): ' contact_email
		read -p $'\n\e[1;96m ->\e[0m Enter Address: ' contact_address
		printf "\n\e[32m Got That! ✔\e[0m\n\n"
		clear
		printf "\e[1;96m                  NEW CONTACT INFO \e[0m\n"
		printf "\n\e[1;90m ->\e[0m First Name: $contact_firstName"
		printf "\n\e[1;90m ->\e[0m Last Name: $contact_lastName"
		printf "\n\e[1;90m ->\e[0m Gender: $contact_gender"
		printf "\n\e[1;90m ->\e[0m Phone Number: $contact_number"
		printf "\n\e[1;90m ->\e[0m E-mail: $contact_email"
		printf "\n\e[1;90m ->\e[0m Address: $contact_address"

	;;
	
	2);;
	
	3);;
	
	4);;
	
	5)
		exit 1;
	;;

	*)
		printf "\n\e[31m INVALID OPTION! ❌\e[0m\n"
	;;
	esac;
	read -p $'\n\n\e[1;96m ->\e[0m Press 5 to exit, Press Enter OR Anything else to Return to Main Menu: ' is_exit
	if [[ $is_exit -eq 5 ]];
	then exit 1;
	fi
	clear
}

clear
connectMongo
while :
do
banner
startMyScript
done