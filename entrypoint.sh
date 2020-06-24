#!/bin/bash -l
#Testing git log
set -e
GIT_LOG=`git log --pretty="%an %ae%n%cn %ce" | sort | uniq`
var=$( IFS=$'\n'; echo "${GIT_LOG[*]}" )
log_data=${$var%?}
generate_post_data()
{
  cat <<EOF
{
  "username":"$GITHUB_ACTOR",
  "repository":"$GITHUB_REPOSITORY",
  "workflow":"$GITHUB_WORKFLOW",
  "run_ID":"$GITHUB_RUN_ID",
  "run_Number":"$GITHUB_RUN_NUMBER",
  "event":"$GITHUB_EVENT_NAME",
  "shortlog":"$log_data"
}
EOF
}
curl -d "$(generate_post_data)" -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
