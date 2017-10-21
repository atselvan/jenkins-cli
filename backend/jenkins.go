package backend

import (
	"../model"
	"fmt"
	"encoding/json"
)

func GetJenkinsJobs(jenkinsUrl string, user model.User, verbose bool) {

	url := jenkinsUrl + "/api/json?pretty"
	responseBody := httpRequest(url, "GET", user.Username, user.Password, verbose)

	var jsonOutput model.Jobs
	json.Unmarshal(responseBody, &jsonOutput)

		var count = 0
		for _, jobs := range jsonOutput.Jobs {
			fmt.Println(string(jobs.Name))
			count ++
		}
		fmt.Println("Number of folders in " + jenkinsUrl + " :", count)

}

func CreateJenkinsFolder(jenkinsUrl string, folderName string, user model.User, verbose bool){
	url := jenkinsUrl + "/createItem?name=" + folderName + "&mode=com.cloudbees.hudson.plugins.folder.Folder"
	httpRequest(url, "POST", user.Username, user.Password, verbose)
}

func CreateRole(jenkinsUrl, roleName string, user model.User, verbose bool){
	url := jenkinsUrl + "/roles/createRole/api/json?name=" + roleName
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func DeleteRole(jenkinsUrl, roleName string, user model.User, verbose bool){
	url := jenkinsUrl + "/roles/deleteRole/api/json?name=" + roleName
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func GrantPermissionToRole(jenkinsUrl, roleName, permission string, user model.User, verbose bool){
	url := jenkinsUrl + "/roles/" + roleName + "/grantPermissions/api/json?permissions=" + permission
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func RevokePermissionsFromRole(jenkinsUrl, roleName, permission string, user model.User, verbose bool){
	url := jenkinsUrl + "/roles/" + roleName + "/revokePermissions/api/json?permissions=" + permission
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func RevokeAllPermissionsFromRole(jenkinsUrl, roleName string, user model.User, verbose bool){
	url := jenkinsUrl + "/roles/" + roleName + "/api/json"
	responseBody := httpRequest(url,"POST", user.Username, user.Password, verbose)

	var jsonOutput model.RolePermissions
	json.Unmarshal(responseBody, &jsonOutput)

	for _, permission := range jsonOutput.GrantedPermissions {
		RevokePermissionsFromRole(jenkinsUrl, roleName, permission, user, verbose)
	}
}

func CreateGroup(jenkinsUrl, group string, user model.User, verbose bool){
	url := jenkinsUrl + "/groups/createGroup/api/json?name=" + group
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func DeleteGroup(jenkinsUrl, group string, user model.User, verbose bool){
	url := jenkinsUrl + "/groups/deleteGroup/api/json?name=" + group
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func AddRoleToGroup(jenkinsUrl, group, role string, user model.User, verbose bool){
	url := jenkinsUrl + "/groups/" + group + "/grantRole/api/json?role=" + role + "&offset=0&inherited=true"
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}

func AddMemberToGroup(jenkinsUrl, group, member string, user model.User, verbose bool){
	url := jenkinsUrl + "/groups/" + group + "/addMember/api/json?name=" + member
	httpRequest(url,"POST", user.Username, user.Password, verbose)
}



