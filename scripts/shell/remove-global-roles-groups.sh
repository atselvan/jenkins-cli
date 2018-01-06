#!/bin/bash
# Removes Jenkins RBAC roles and groups
# Usage : ./remove-global-roles-groups.sh <JENKINS_URL> <JENKINS_USER> <JENKINS_PASS>
#==========================================================
# Variables
#==========================================================
JENKINS_URL=$1
JENKINS_USER=$2
JENKINS_PASS=$3

PROPERTY_FILE="../properties/role-permissions.properties"
CLI_FILE="./jenkins-cli"

#==========================================================
# Functions
#==========================================================
function getProperty {
   PROP_KEY=$1
   grep "${PROP_KEY}" $PROPERTY_FILE | cut -d'=' -f2
   echo $PROP_VALUE
}

function deleteRole {
    ${CLI_FILE} -deleteRole -jenkinsURL ${JENKINS_URL} -username ${JENKINS_USER} -password ${JENKINS_PASS} -roleName ${1}
}

function deleteGroup {
    ${CLI_FILE} -deleteGroup -jenkinsURL ${JENKINS_URL} -username ${JENKINS_USER} -password ${JENKINS_PASS} -groupName ${1}
}

#==========================================================
# Check if input paramters are correct
#==========================================================
if [[ $# -lt 3 || $# -gt 3 ]]
  then
    echo "Usage : ./remove-global-roles-groups.sh <JENKINS_URL> <JENKINS_USER> <JENKINS_PASS>"
    exit 1
fi

#==========================================================
# Check if the properties file exist
#==========================================================
if [ -f "$PROPERTY_FILE" ]
then
  echo "Properties file found."
else
  echo "$PROPERTY_FILE file not found."
fi

#==========================================================
# Check if the cli file exist
#==========================================================
if [ -f "$CLI_FILE" ]
then
  echo "CLI file found."
else
  echo "$CLI_FILE file not found."
fi

#==========================================================
# Remove Administrator role and group
#==========================================================
ROLE_NAME="administrator"
GROUP_NAME="ADMINISTRATORS"

deleteGroup ${GROUP_NAME}
deleteRole ${ROLE_NAME}

#==========================================================
# Remove User role and group
#==========================================================
ROLE_NAME="user"
GROUP_NAME="USERS"

${CLI_FILE} -deleteGroup -jenkinsURL ${JENKINS_URL} -username ${JENKINS_USER} -password ${JENKINS_PASS} -groupName USERS
deleteRole ${ROLE_NAME}

#==========================================================
# Remove Reviewer role and group
#==========================================================
ROLE_NAME="reviewer"
GROUP_NAME="REVIEWERS"

deleteGroup ${GROUP_NAME}
deleteRole ${ROLE_NAME}

#==========================================================
# Remove dev-user role
#==========================================================
ROLE_NAME="dev-user"
PERMISSIONS=$(getProperty $ROLE_NAME)

deleteRole ${ROLE_NAME}

#==========================================================
# Remove Reader role
#==========================================================
ROLE_NAME="reader"
PERMISSIONS=$(getProperty $ROLE_NAME)

deleteRole ${ROLE_NAME}

#==========================================================
# Remove Developer role
#==========================================================
ROLE_NAME="developer"
PERMISSIONS=$(getProperty $ROLE_NAME)

deleteRole ${ROLE_NAME}

#==========================================================
# Remove node-manager role and group
#==========================================================
ROLE_NAME="node-manager"
GROUP_NAME="NODE-MANAGERS"

deleteGroup ${GROUP_NAME}
deleteRole ${ROLE_NAME}

#==========================================================
# End of script
#==========================================================