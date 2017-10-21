package main

import (
	"./backend"
	"./model"
	"flag"
	"log"
	"os"
)

func main() {

	// Flags

	list := flag.Bool("list", false, "Get a list of all the folder on the root level of Jenkins")
	create := flag.Bool("create", false, "Create a folder in the root level of Jenkins")
	createRole := flag.Bool("createRole", false, "Create a RBAC role in jenkins. Required arguments: roleName, rolePermissions")
	deleteRole := flag.Bool("deleteRole", false, "Delete a RBAC role from jenkins.")
	createGroup := flag.Bool("createGroup", false, "Create a group in the root level of Jenkins")
	deleteGroup := flag.Bool("deleteGroup", false, "Delete a group from the root level of Jenkins")
	username := flag.String("username", "", "Username for authentication")
	password := flag.String("password", "", "Password for authentication")
	jenkinsUrl := flag.String("jenkinsUrl", "", "Jenkins server URL")
	folderName := flag.String("folderName", "", "Name of the Jenkins folder")
	roleName := flag.String("roleName", "", "Role name.")
	rolePermissions := flag.String("rolePermissions", "", "Comma separated values of role permissions")
	groupName := flag.String("groupName", "", "Group Name.")
	member := flag.String("member", "", "Member value to grant access")
	verbose := flag.Bool("verbose", false, "For debug logs set this flag")
	flag.Parse()

	flag.Args()

	if *username == "" || *password == "" {
		log.Fatal("Username and password is mandatory")
	} else if *jenkinsUrl == "" {
		log.Fatal("Please provide the URL of the Jenkins server")
	}

	user := model.User{Username: *username, Password: *password}

	if *list == true {
		backend.GetJenkinsJobs(*jenkinsUrl, user, *verbose)
	} else if *create == true {
		backend.CreateJenkinsFolder(*jenkinsUrl, *folderName, user, *verbose)
	} else if *createRole == true {
		if *roleName == "" {
			log.Fatal("You have not provided a valid role name")
		} else if *rolePermissions == "" {
			log.Fatal("You have not provided a valid role permission")
		} else {
			backend.CreateRole(*jenkinsUrl, *roleName, user, *verbose)
			backend.GrantPermissionToRole(*jenkinsUrl, *roleName, *rolePermissions, user, *verbose)
		}
	} else if *deleteRole == true {
		if *roleName == "" {
			log.Fatal("You have not provided a valid role name")
		} else {
			backend.RevokeAllPermissionsFromRole(*jenkinsUrl, *roleName, user, *verbose)
			backend.DeleteRole(*jenkinsUrl, *roleName, user, *verbose)
		}
		backend.DeleteRole(*jenkinsUrl, *roleName, user, *verbose)
	} else if *createGroup == true {
		if *groupName == "" {
			log.Fatal("You have not provided a valid group name")
		} else if *roleName == "" {
			log.Fatal("You have not provided a valid role name")
		} else if *member == "" {
			log.Fatal("You have not provided a valid member name")
		} else {
			backend.CreateGroup(*jenkinsUrl, *groupName, user, *verbose)
			backend.AddRoleToGroup(*jenkinsUrl, *groupName, *roleName, user, *verbose)
			backend.AddMemberToGroup(*jenkinsUrl, *groupName, *member, user, *verbose)
		}
	} else if *deleteGroup == true {
		if *groupName == "" {
			log.Fatal("You have not provided a valid group name")
		} else {
			backend.DeleteGroup(*jenkinsUrl, *groupName, user, *verbose)
		}
	}else {
		flag.Usage()
		log.Printf("Select a valid action flag")
		os.Exit(1)
	}
}
