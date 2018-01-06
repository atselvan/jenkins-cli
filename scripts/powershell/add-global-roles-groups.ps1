#!/bin/bash
# Creates global roles and groups to Jenkins Masters
# Example: create-global-roles-groups.ps1 -JenkinsUrl https://t-jenkins-m01.development.nl.eu.abnamro.com:9443 -Username **** -Password ****

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
$Permissions = "hudson.model.Hudson.Administer"
$member = "HUDSON_ADMINISTRATOR"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions
./jenkins-cli.exe -createGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName -roleName $RoleName -member $member

# User role
$RoleName = "user"
$GroupName = "USERS"
$Permissions = "hudson.model.Hudson.Read,hudson.model.Item.Create,hudson.model.View.Read"
$member = "HUDSON_USER"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions
./jenkins-cli.exe -createGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName -roleName $RoleName -member $member

# Dev-User role
$RoleName = "dev-user"
$Permissions = "com.cloudbees.jenkins.plugins.git.vmerge.CommitSpoolRepository.Pull,com.cloudbees.jenkins.plugins.git.vmerge.CommitSpoolRepository.Push,hudson.model.Item.Build,hudson.model.Item.Cancel,hudson.model.Item.Discover,hudson.model.Item.Read,hudson.model.Item.ViewStatus"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions

# Reviewer role
$RoleName = "reviewer"
$GroupName = "REVIEWERS"
$Permissions = "com.cloudbees.jenkins.plugins.git.vmerge.CommitSpoolRepository.Pull,com.cloudbees.jenkins.plugins.git.vmerge.CommitSpoolRepository.Push,com.cloudbees.plugins.credentials.CredentialsProvider.View,hudson.model.Hudson.Read,hudson.model.Item.Build,hudson.model.Item.Cancel,hudson.model.Item.Configure,hudson.model.Item.Discover,hudson.model.Item.Read,hudson.model.Item.Request,hudson.model.Item.ViewStatus,hudson.model.Item.Workspace,hudson.model.Run.Replay,hudson.model.View.Read,nectar.plugins.rbac.groups.Group.View,nectar.plugins.rbac.roles.Role.View"
$member = "HUDSON_REVIEWERS"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions
./jenkins-cli.exe -createGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName -roleName $RoleName -member $member

# Reader role
$RoleName = "reader"
$Permissions = "com.cloudbees.plugins.credentials.CredentialsProvider.View,hudson.model.Item.Discover,hudson.model.Item.Read,hudson.model.Item.ViewStatus,hudson.model.View.Read,nectar.plugins.rbac.groups.Group.View,nectar.plugins.rbac.roles.Role.View"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions

# Developer role
$RoleName = "developer"
$Permissions = "com.cloudbees.jenkins.plugins.git.vmerge.CommitSpoolRepository.Pull,com.cloudbees.jenkins.plugins.git.vmerge.CommitSpoolRepository.Push,com.cloudbees.plugins.credentials.CredentialsProvider.View,hudson.model.Item.Build,hudson.model.Item.Cancel,hudson.model.Item.Configure,hudson.model.Item.Create,hudson.model.Item.Delete,hudson.model.Item.Discover,hudson.model.Item.Move,hudson.model.Item.Promote,hudson.model.Item.Read,hudson.model.Item.Release,hudson.model.Item.Request,hudson.model.Item.ViewStatus,hudson.model.Item.Workspace,hudson.model.Run.Delete,hudson.model.Run.Replay,hudson.model.Run.Update,hudson.model.View.Configure,hudson.model.View.Create,hudson.model.View.Delete,hudson.model.View.Read,nectar.plugins.rbac.groups.Group.View,nectar.plugins.rbac.roles.Role.View"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions

# Node-Manager role
$RoleName = "node-manager"
$GroupName = "NODE-MANAGERS"
$Permissions = "hudson.model.Computer.Build,hudson.model.Computer.Configure,hudson.model.Computer.Connect,hudson.model.Computer.Create,hudson.model.Computer.Delete,hudson.model.Computer.Disconnect,hudson.model.Computer.Provision,hudson.model.Computer.Secure,hudson.model.Computer.ViewOwners,hudson.model.Hudson.Read"
$member = "SOLO_JENKINS_AGENT"

./jenkins-cli.exe -createRole -jenkinsUrl $JenkinsUrl -username $Username -password $Password -roleName $RoleName -rolePermissions $Permissions
./jenkins-cli.exe -createGroup -jenkinsUrl $JenkinsUrl -username $Username -password $Password -groupName $GroupName -roleName $RoleName -member $member

# End Of Script