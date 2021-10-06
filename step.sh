#!/bin/bash

red=$'\e[31m'
green=$'\e[32m'
reset=$'\e[0m'

body='{
  "description": "'${version_description}'",
  "name": "'${version_name}'",
  "archived": false,
  "project": "'${project_prefix}'",
'

today=$(date +'%Y-%m-%d')

if [ "$version_released" = "yes"];
then
body+='  "released": true,
  "releaseDate": "'$today'",
'
fi
body+='  "startDate": "'$today'"
}'

res="$(curl -u $jira_user:$jira_token -X POST -H 'Content-Type: application/json' --data-raw "${body}" https://${jira_domain}/rest/api/2/version)"

if [[ $res == *"errorMessages"* ]]; then
  echo '$'\t'"${red}❗️ Failed${reset} "$res
else
  echo $'\t'"${green}✅ Success!${reset}"
fi