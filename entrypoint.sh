#!/bin/bash -l
# Testing git log
set -e
log_data=`git log --pretty="%an %ae%n%cn %ce" | sort | uniq`
#function join { local IFS="$1"; shift; echo "$*"; }
#log_data=$(join , ${GIT_LOG[@]})
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
echo $GITHUB_ACTOR
echo $GITHUB_REPOSITORY
echo $GITHUB_WORKFLOW
echo $GITHUB_RUN_ID
echo $GITHUB_RUN_NUMBER
echo $GITHUB_EVENT_NAME
echo $log_data

curl -H "Content-Type: application/json" -d "$(generate_post_data)" https://ghatracker.herokuapp.com/
