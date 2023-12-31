#!/bin/bash

curl -L -o /usr/bin/jq.exe https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe

GITHUB_TOKEN="******"
ACCESS_TOKEN="******"

cd ../deploy
echo "Calling terraform init"
terraform init
echo "Starting deployment"
terraform apply -input=false -auto-approve -var="github_token=${GITHUB_TOKEN}"

HOSTNAME="$(terraform output -raw aws_lb_dns_name)"
echo "Calling ${HOSTNAME}/count-words"
echo

PAYLOAD='{"fileName": "file1.txt"}'
RESPONSE=`curl -s --request POST -H "Content-Type:application/json" -H "Authorization:${ACCESS_TOKEN}" ${HOSTNAME}/count-words --data "${PAYLOAD}"` | jq
# shellcheck disable=SC2006
RESPONSE_MSG=`curl -s --request POST -H "Content-Type:application/json" -H "Authorization:${ACCESS_TOKEN}" ${HOSTNAME}/count-words --data "${PAYLOAD}"` | jq.message

echo "RESPONSE: ${RESPONSE}"
echo "RESPONSE_MSG: ${RESPONSE_MSG}"

terraform destroy -input=false -auto-approve -var="github_token=${GITHUB_TOKEN}"

echo
echo "*****************"
echo "RESPONSE: ${RESPONSE}"
echo "RESPONSE_MSG: ${RESPONSE_MSG}"
if [ "RESPONSE_MSG" = "please find your output file in cp-output-files bucket" ]; then
    echo "SUCCESS"
else
    echo "FAILURE"
fi
echo "*****************"
