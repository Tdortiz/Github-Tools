#!/bin/bash
#####################################################################
#                           Author                                  #
#                       tdortiz@ncsu.edu                            #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
# Allows for deep copying (including commits/branches) of a github  #
# repo.                                                             #
#                                                                   #
# This is useful for moving repos from one account to another.      #
#                                                                   #
#####################################################################

#####################################################################
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
printf "This script allows for deep copying (including commits/branches) of a github repo to a new repo.\n"
printf 'Run Options: "./deepCopyRepo.sh" OR "./deepCopyRepo.sh <username> <old_repo_url>"\n\n'

username=""
oldRepoUrl=""

# Get input from user or cli
if [ $# -eq 0 ] 
then 
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
