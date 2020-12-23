#!/usr/bin/env bash
# BashPhoneBook v1.0
# Coded by: BHMBS IBRAHIM Student At ISET Nabeul - Tunisia
# Github: https://github.com/barhouum7/BashPhoneBook

# trap 'echo exiting cleanly...; exit 1;' SIGINT SIGTSTP

checkroot() {

if [[ "$(id -u)" -ne 0 ]]; then
   printf "\n\n\e[1;77mPlease, run this program as root!\n\e[0m"
   exit 1
fi

}

checkroot

printf "\n\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Installing packages..\e[0m\n"


if [[ -e mongodb-linux-*-4.4.2.tgz* ]]; then
echo ""
else

if [[ ! -e mongodb-linux-*-4.4.2.tgz* ]]; then

(trap '' SIGINT SIGTSTP && command -v mongo > /dev/null 2>&1 || { printf >&2  "\n\e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92mInstalling MongoDB, please wait...\n\e[0m"; apt-get update > /dev/null && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-4.4.2.tgz && sudo apt-get install libcurl4 openssl liblzma5 curl wget -y && tar -zxvf ./mongodb-linux-*-4.4.2.tgz && sudo cp ./mongodb-linux-x86_64-ubuntu2004-4.4.2/bin/* /usr/local/bin/ > /dev/null || printf "\n\n\e[1;91mMongoDB NOT installed.\n\n\e[0m"; }) & wait $!

else
printf "\n\n\e[1;93m[!] Download Error... \e[0m\n\n"
exit 1
fi
fi



printf "\n\e[32m Installed Successfully! ✔\e[0m\n\n"
printf "\n\e[1;32m You are already have MongoDB Installed in your Machine! ✔\e[0m\n\n\n\e[1;94mInfo Of Installed Version:\e[0m\n\n" mongo --version