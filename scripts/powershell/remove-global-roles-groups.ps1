#!/bin/bash
# Deletes global roles and groups to Jenkins Masters
# Example: delete-global-roles-groups.ps1 -JenkinsUrl https://t-jenkins-m01.development.nl.eu.abnamro.com:9443 -Username **** -Password ****

#Input parameter
Param (
  [string] $JenkinsUrl,
  [string] $Username,
  [string] $Password
) 

if(-not($JenkinsUrl)) { 
Write-Host "You must supply a value for -JenkinUrl -Username and -Password" -ForegroundColor Red
exit 
}
if(-not($Username)) { 
Write-Host "You must supply a value for -JenkinUrl -Username and -Password" -ForegroundColor Red
exit 
}
if(-not($Password)) { 
Write-Host "You must supply a value for -JenkinUrl -Username and -Password" -ForegroundColor Red
exit 
}

# Administrator role
$RoleName = "administrator"
$GroupName = "ADMINISTRATORS"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName
./jenkins-cli.exe -deleteGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName 

# User role
$RoleName = "user"
$GroupName = "USERS"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName
./jenkins-cli.exe -deleteGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName

# Dev-User role
$RoleName = "dev-user"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName

# Reviewer role
$RoleName = "reviewer"
$GroupName = "REVIEWERS"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName
./jenkins-cli.exe -deleteGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName

# Reader role
$RoleName = "reader"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName

# Developer role
$RoleName = "developer"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName

# Node-Manager role
$RoleName = "node-manager"
$GroupName = "NODE-MANAGERS"

./jenkins-cli.exe -deleteRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName
./jenkins-cli.exe -deleteGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName


# End Of Script