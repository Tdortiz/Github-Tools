#!/bin/bash
#####################################################################
#                                                                   #
#                           Author                                  #
#                       tdortiz@ncsu.edu                            #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
# Allows for deep copying (including commits/branches) of a github  #
# repo.                                                             #
#                                                                   #
# It does so by creating a new repo for you on your github account  #
# with the name of the old repo and mirrors the old repo to the new.#
#                                                                   #
# This is useful for moving repos from one account to another.      #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
#                           Running                                 #
#                     chmod +x deepCopyRepo.sh                      #
#                                                                   #
#                       ./deepCopyRepo.sh                           #
#                               OR                                  #
#               ./deepCopyRepo.sh <username> <old_repo_url>         #
#                                                                   #
#####################################################################

# Clean the terminal
clear

username=""
oldRepoUrl=""

# A function that checks requirements for the script to run successfully
function checkRequirements {
    command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }
}

checkRequirements

# Get input from user or cli
if [ $# -eq 0 ] 
then 
    printf "This script allows for deep copying (including commits/branches) of a github repo to a new repo.\n"
    printf 'Run Options: "./deepCopyRepo.sh" OR "./deepCopyRepo.sh <username> <old_repo_url>"\n\n'
    read -p "Github Username :  " username
    read -p "Repo To Copy url:  " oldRepoUrl
else
    username=$1
    oldRepoUrl=$2
fi

# Parse old url for the repo name
oldRepoName=$(echo ${oldRepoUrl} | cut -d/ -f2- | cut -d/ -f2- | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f1)
oldRepoDir=$oldRepoName'.git'

# Create new repository on github with name of old repo
curl -u $username https://api.github.com/user/repos -d '{"name":"'$oldRepoName'","description":"Deep Copy Of Another Repo"}'
newURL='https://github.com/'$username'/'$oldRepoDir

# Completely copy the old repo to the new repo
git clone --mirror $oldRepoUrl
cd $oldRepoDir
git remote add new-origin $newURL
git push new-origin --mirror

# Go back github base folder and delete .git folder we cloned
cd ..
rm -rf $oldRepoDir
