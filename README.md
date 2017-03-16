# Github-Tools

## Dependencies
All scripts require cURL

## deepCopyRepo.sh
Allows for deep copying (including commits/branches/collaborators/ect.) of a github repo. 

It does so by creating a new repo on the user's account and mirroring the old repo to the new one.

This is useful for moving repos from one account to another.

### Usage
Ran by:
* ./deepCopyRepo.sh
* ./deepCopyRepo.sh <username> <old_repo_url> 

## createRepo.sh
Allows for creations of a github repository from the command line.

### Usuage
Ran by:
* ./createRepo.sh
* ./createRepo.sh <username> <new repo name> 
