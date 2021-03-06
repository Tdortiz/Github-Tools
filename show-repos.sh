#!/bin/bash
#####################################################################
#                                                                   #
#                           Author                                  #
#                       tdortiz@ncsu.edu                            #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
#                Gets all of a user's public repos                  #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
#                           Running                                 #
#                     chmod +x show-repos.sh                        #
#                                                                   #
#                       ./show-repos.sh                             #
#                               OR                                  #
#               ./show-repos.sh <username>                          #
#                                                                   #
#####################################################################

# Clean the terminal
clear;
USER=""

# A function that checks requirements for the script to run successfully
function checkRequirements {
    command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }
}

checkRequirements

# Get input from user or cli
if [ $# -eq 0 ] 
then
    printf "This script returns all of a user's public repos.\n"
    printf 'Run Options: "./show-repos.sh <username>"\n\n'
    read -p "USER :  " USER
else
    USER=$1
fi

# Create new repository on the user's github
curl "https://api.github.com/users/$USER/repos?per_page=1000" --silent | grep -o 'https://github.com/[^"]*\.git'
