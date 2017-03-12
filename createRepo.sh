#!/bin/bash
#####################################################################
#                                                                   #
#                           Author                                  #
#                       tdortiz@ncsu.edu                            #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
# Allows for creation of a github repository on the user's github   #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
#                           Running                                 #
#                     chmod +x createRepo.sh                        #
#                                                                   #
#                       ./createRepo.sh                             #
#                               OR                                  #
#               ./createRepo.sh <username> <new repo name>          #
#                                                                   #
#####################################################################

# Clean the terminal
clear

username=""
newRepoName=""

# Get input from user or cli
if [ $# -eq 0 ] 
then
    printf "This script creates a new github repo.\n"
    printf 'Run Options: "./createRepo.sh" OR "./createRepo.sh <username> <new repo name>"\n\n'
    read -p "Github Username :  " username
    read -p "New Repo Name   :  " newRepoName
else
    username=$1
    newRepoName=$2
fi

# Create new repository on the user's github
curl -u $username https://api.github.com/user/repos -d '{"name":"'$newRepoName'", "description":"Created via Github API", "auto_init":"true"}'
