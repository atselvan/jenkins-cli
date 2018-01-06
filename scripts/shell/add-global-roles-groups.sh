#!/bin/bash
# Adds Jenkins RBAC roles and groups
# Usage : ./add-global-roles-groups.sh <JENKINS_URL> <JENKINS_USER> <JENKINS_PASS>
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

function createRole {
    ${CLI_FILE} -createRole -jenkinsURL ${JENKINS_URL} -username ${JENKINS_USER} -password ${JENKINS_PASS} -roleName ${1} -rolePermissions ${2}
}

function createGroup {
    ${CLI_FILE} -createGroup -jenkinsURL ${JENKINS_URL} -username ${JENKINS_USER} -password ${JENKINS_PASS} -groupName ${1} -roleName ${2} -memberID ${3}
}

#==========================================================
# Check if input paramters are correct
#==========================================================
if [[ $# -lt 3 || $# -gt 3 ]]
  then
    echo "Usage : ./add-global-roles-groups.sh <JENKINS_URL> <JENKINS_USER> <JENKINS_PASS>"
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
# Add Administrator role and group
#==========================================================
ROLE_NAME="administrator"
GROUP_NAME="ADMINISTRATORS"
PERMISSIONS=$(getProperty $ROLE_NAME)
MEMBER_ID="JENKINS_ADMINISTRATORS"

createRole ${ROLE_NAME} ${PERMISSIONS}
createGroup ${GROUP_NAME} ${ROLE_NAME} ${MEMBER_ID}

#==========================================================
# Add User role and group
#==========================================================
ROLE_NAME="user"
GROUP_NAME="USERS"
PERMISSIONS=$(getProperty $ROLE_NAME)
MEMBER_ID="JENKINS_USERS"

createRole ${ROLE_NAME} ${PERMISSIONS}
createGroup ${GROUP_NAME} ${ROLE_NAME} ${MEMBER_ID}

#==========================================================
# Add Reviewer role and group
#==========================================================
ROLE_NAME="reviewer"
GROUP_NAME="REVIEWERS"
PERMISSIONS=$(getProperty $ROLE_NAME)
MEMBER_ID="JENKINS_REVIEWERS"

createRole ${ROLE_NAME} ${PERMISSIONS}
createGroup ${GROUP_NAME} ${ROLE_NAME} ${MEMBER_ID}

#==========================================================
# Add dev-user role
#==========================================================
ROLE_NAME="dev-user"
PERMISSIONS=$(getProperty $ROLE_NAME)

createRole ${ROLE_NAME} ${PERMISSIONS}

#==========================================================
# Add Reader role
#==========================================================
ROLE_NAME="reader"
PERMISSIONS=$(getProperty $ROLE_NAME)

createRole ${ROLE_NAME} ${PERMISSIONS}

#==========================================================
# Add Developer role
#==========================================================
ROLE_NAME="developer"
PERMISSIONS=$(getProperty $ROLE_NAME)

createRole ${ROLE_NAME} ${PERMISSIONS}

#==========================================================
# Add node-manager role and group
#==========================================================
ROLE_NAME="node-manager"
GROUP_NAME="NODE-MANAGERS"
PERMISSIONS=$(getProperty $ROLE_NAME)
MEMBER_ID="JENKINS_AGENT"

createRole ${ROLE_NAME} ${PERMISSIONS}
createGroup ${GROUP_NAME} ${ROLE_NAME} ${MEMBER_ID}

#==========================================================
# End of script
#==========================================================