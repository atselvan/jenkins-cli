# Jenkins CLI

This tool can be used to communicate with a Cloudbees Jenkins server.

```go
Usage of C:\LogFiles\allan\workspace\go\jenkins-cli\jenkins-cli.exe:
  -create
        Create a folder in the root level of Jenkins
  -createGroup
        Create a group in the root level of Jenkins
  -createRole
        Create a RBAC role in jenkins. Required arguments: roleName, rolePermissions
  -deleteGroup
        Delete a group from the root level of Jenkins
  -deleteRole
        Delete a RBAC role from jenkins.
  -folderName string
        Name of the Jenkins folder
  -groupName string
        Group Name.
  -jenkinsUrl string
        Jenkins server URL
  -list
        Get a list of all the folder on the root level of Jenkins
  -member string
        Member value to grant access
  -password string
        Password for authentication
  -roleName string
        Role name.
  -rolePermissions string
        Comma separated values of role permissions
  -username string
        Username for authentication
  -verbose
        For debug logs set this flag
```