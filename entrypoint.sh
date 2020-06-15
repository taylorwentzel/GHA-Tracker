#!/bin/sh -l
generate_post_data()
{
  cat <<EOF
{
  "username":"$GITHUB_ACTOR",
  "name":"$GITHUB_REPOSITORY"
}
EOF
}
curl -d "$(generate_post_data)" -H "Content-Type: application/json" -X POST https://ghatracker.herokuapp.com/
