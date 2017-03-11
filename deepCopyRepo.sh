#!/bin/bash
#
# Allows for deep copying (including commits/branches)
# of a github repo. This is useful for moving repos from 
# one account to another.
#
# @author tdortiz (tdortiz@ncsu.edu)
clear
printf "This script allows for deep copying (including commits/branches) of a github repo to a new repo.\n\n"

# Retreives user input 
read -p "Github Username :  " username
read -p "Repo To Copy url:  " oldRepoUrl

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