#!/bin/sh -l
#Testing git log
set -e

echo "#################################################"
echo "Starting the git Action"
pwd
sh -c "git log"

echo "#################################################"
echo "Completed the git Action"

generate_post_data()
{
  cat <<EOF
{
  "username":"$GITHUB_ACTOR",
  "repository":"$GITHUB_REPOSITORY",
  "workflow":"$GITHUB_WORKFLOW",
  "run_ID":"$GITHUB_RUN_ID",
  "run_Number":"$GITHUB_RUN_NUMBER",
  "event":"$GITHUB_EVENT_NAME"
}
EOF
}
curl -d "$(generate_post_data)" -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
