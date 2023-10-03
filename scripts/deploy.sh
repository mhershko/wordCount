#!/bin/bash

cd ../deploy
echo "Calling terraform init"
terraform init
echo "Starting deployment"
terraform apply -input=false -auto-approve -var="github_token=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"

HOSTNAME="$(terraform output -raw aws_lb_dns_name)"
echo "Calling ${HOSTNAME}/count-words"
echo

PAYLOAD='{"fileName": "file1.txt"}'
RESPONSE=`curl -s --request POST -H "Content-Type:application/json" -H "Authorization:aaa" ${HOSTNAME}/count-words --data "${PAYLOAD}"`

echo "RESPONSE: ${RESPONSE}"

RESPONSE_MSG=$(\
    curl -s --request POST -H "Content-Type:application/json" -H "Authorization:aaa" ${HOSTNAME}/count-words --data "${PAYLOAD}" \
    | python -c "import sys, json; print json.load(sys.stdin)['data']['message']"\
)

echo "RESPONSE_MSG: ${RESPONSE_MSG}"

if [ "RESPONSE_MSG" = "please find your output file in cp-output-files bucket" ]; then
    echo "SUCCESS"
else
    echo "FAILURE"
fi