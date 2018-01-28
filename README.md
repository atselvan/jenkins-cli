# Jenkins CLI

This tool can be used to communicate with a Cloudbees Jenkins server.

```go
Usage of ./jenkins-cli:
  -createFolder
    	Create a folder in the root level of Jenkins. Required: folderName
  -createGroup
    	Create a group on the root level of Jenkins. Required: groupName, roleName, memberId
  -createRole
    	Create a RBAC role on the root level of Jenkins. Required: roleName, rolePermissions
  -deleteFolder
    	Deletes a folder on the root level of Jenkins. Required: folderName
  -deleteGroup
    	Delete a group from the root level of Jenkins
  -deleteRole
    	Delete a RBAC role from jenkins.
  -folderName string
    	Name of the Jenkins folder
  -groupName string
    	Group Name.
  -jenkinsURL string
    	Jenkins server URL (default "http://cicd.privatesquare.in:8080")
  -listFolders
    	Get a list of all the folder on the root level of Jenkins
  -memberID string
    	Member ID to grant access to a group
  -password string
    	Password for authentication (default "welkom")
  -roleName string
    	Role name.
  -rolePermissions string
    	Comma separated values of role permissions
  -username string
    	Username for authentication (default "allan.selvan")
  -verbose
    	For debug logs set this flag

```