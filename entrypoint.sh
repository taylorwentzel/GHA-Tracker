#!/bin/sh -l
#Testing git log
set -e
GIT_LOG=`git log -p | grep ^- | grep cronwrapper | \
grep '@' | sed 's/.* \(.*@.*\)/\1/' | awk '{ print $1 }' | \
sed -e 's/\\"//g' -e 's/"//g' -e "s/'//g" | \
tr '[A-Z]' '[a-z]' | \
awk '{ gsub(";", "\n"); print $0 }' | \
sort | uniq | \
awk 'ORS=";" { print $0 } END { ORS="\n"; print "" }'`
echo "$GIT_LOG"
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
  "shortlog":"$GIT_LOG"
}
EOF
}
curl -d "$(generate_post_data)" -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
