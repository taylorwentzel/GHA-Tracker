#!/bin/sh -l
#Testing git log
set -e
echo 'print directly'
git log
echo 'print from variable'
shortlog=$(git log)
echo "$shortlog"
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
  "shortlog":"$shortlog"
}
EOF
}
#curl -d "$(generate_post_data)" -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
