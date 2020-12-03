#!/usr/bin/env bash
# BashPhoneBook v1.0
# Coded by: BHMBS IBRAHIM Student At ISET Nabeul - Tunisia
# Github: https://github.com/barhouum7/BashPhoneBook



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
	read -p $'\e[1;96m ->\e[0m Enter Name: ' contact_name
	printf "\e[32m Got That! ✔\e[0m\n\n"
	;;
	2);;
	3);;
	4);;
	5)
	exit 1;
	;;
	*)
	printf "\e[31m INVALID OPTION! ❌\e[0m\n"
	;;
	esac;
	read -p $'\e[1;96m ->\e[0m Press 5 to exit, Press Enter OR Anything else to Return to Main Menu: ' is_exit
	if [[ $is_exit -eq 5 ]];
	then exit 1;
	fi
}

clear
while :
do
banner
startMyScript
done